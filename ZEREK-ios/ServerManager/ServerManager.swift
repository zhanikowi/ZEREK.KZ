//
//  ServerManager.swift
//  ZEREK-ios
//
//  Created by bakebrlk on 22.03.2025.
//

import SwiftUI
import Firebase
import FirebaseAuth

final class ServerManager {
    private init() {}
    
    static func signUp(email: String, password: String, user: UserModel) async throws -> UserModel?{
        
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        
        let changeRequest = authDataResult.user.createProfileChangeRequest()
        changeRequest.displayName = user.firstName
        
        do {
            try await changeRequest.commitChanges()
            print(authDataResult.user.displayName ?? "Loading name .....")
            
            return user
        } catch {
            throw error
        }
    }
    
    @discardableResult
    static func login(email: String, password: String) async throws -> UserModel? {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        
        guard let userEmail = authDataResult.user.email,
              let user = try await fetchUser(email: userEmail)
        else {
            print("returned nil")
            return nil
        }
        
        return user
    }
    
    @discardableResult
    static func getAuthenticatedUser() throws -> UserModel? {
        guard Auth.auth().currentUser != nil
        else {
            return nil
        }
        return UserModel(id: "", firstName: "", lastName: "", email: "", languageLevel: "", age: "", purpose: "")
    }
    
    public static func fetchUser(email: String) async throws -> UserModel? {
        let db = Firestore.firestore()
        
        let querySnapshot = try await db.collection("users")
            .whereField("email", isEqualTo: email)
            .getDocuments()
        
        guard let firstDocument = querySnapshot.documents.first else {
            print("User not found!")
            return nil
        }
        print("Data:", firstDocument.data())
        return UserModel(dictionary: firstDocument.data())
    }
    
    
    public static func signOut() throws {
        try Auth.auth().signOut()
    }
    
    
    static func resentPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    static func updatePassword(password: String) async throws{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        try await user.updatePassword(to: password)
    }
    
    static func createNewUser(userInfo: UserModel) async throws {
        let userData: [String: Any] = [
            "id": userInfo.id,
            "firstName": userInfo.firstName,
            "lastName": userInfo.lastName,
            "email" : userInfo.email,
            "age": userInfo.age,
            "languageLevel" : userInfo.languageLevel,
            "purpose" : userInfo.purpose
        ]
        
        try await Firestore.firestore().collection("users").document(userInfo.email).setData(userData,merge: false)
    }
    
    private static let db = Firestore.firestore()
    
    static func asyncFetchUnits() async throws -> [Units] {
        let unitNames = ["Unit1"]
        let docNames = ["fillText", "finishSentence", "makeSentence", "correctTranslations"]

        var result: [String: [String: [String: Any]]] = [:]

        for unit in unitNames {
            result[unit] = [:]

            for docName in docNames {
                let snapshot = try await db.collection(unit).document(docName).getDocument()
                if let data = snapshot.data() {
                    result[unit]?[docName] = data
                }
            }
        }

        return parseUnitData(result)
    }

    
    static func parseUnitData(_ rawUnits: [String: [String: [String: Any]]]) -> [Units] {
        var units: [Units] = []
        
        for (unitKey, documents) in rawUnits {
            var fillText: [FillTextItem] = []
            var finishSentence: [FinishSentenceItem] = []
            var correctTranslations: [CorrectTranslationsItem] = []
            var makeSentence: [MakeSentenceItem] = []
            
            for (docName, fields) in documents {
                guard let type = UnitDocumentType(rawValue: docName) else { continue }
                
                switch type {
                case .fillText:
                    if let question = fields["question"] as? String,
                       let correct = fields["correct"] as? String {
                        fillText.append(FillTextItem(question: question, correct: correct))
                    }
                case .finishSentence:
                    if let question = fields["question"] as? String,
                       let options = fields["options"] as? [String],
                       let correctIndex = fields["correct"] as? Int {
                        finishSentence.append(FinishSentenceItem(question: question, options: options, correctIndex: correctIndex))
                    }
                case .correctTranslations:
                    if let question = fields["question"] as? String,
                       let options = fields["options"] as? [String],
                       let correctIndex = fields["correct"] as? Int {
                        correctTranslations.append(CorrectTranslationsItem(question: question, options: options, correctIndex: correctIndex))
                    }
                case .makeSentence:
                    if let question = fields["question"] as? String,
                       let shuffledWords = fields["shuffled"] as? [String],
                       let correctSentence = fields["correct"] as? String {
                        makeSentence.append(MakeSentenceItem(question: question, shuffledWords: shuffledWords, correctSentence: correctSentence))
                    }
                }
            }
            
            let unit = Units(
                fillText: fillText,
                finishSentence: finishSentence,
                correctTranslations: correctTranslations,
                makeSentence: makeSentence
            )
            units.append(unit)
        }
        
        return units
    }
    
    
    
    public static func fetchUser(completion: @escaping (UserModel?) -> Void) {
        guard let email = Auth.auth().currentUser?.email else {
            completion(nil)
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").whereField("email", isEqualTo: email).getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching user: \(error)")
                completion(nil)
                return
            }
            
            guard let document = snapshot?.documents.first else {
                completion(nil)
                return
            }
            
            do {
                let user = try document.data(as: UserModel.self)
                completion(user)
            } catch {
                print("Error decoding user: \(error)")
                completion(nil)
            }
        }
    }
    
    static func updateUserData(firstName: String?, lastName: String?, newPassword: String?, completion: @escaping (Result<UserModel, Error>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "No user", code: 401)))
            return
        }
        
        guard let userEmail = user.email else {
            completion(.failure(NSError(domain: "No user", code: 401)))
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userEmail)
        var updatedFields: [String: Any] = [:]
        
        if let firstName = firstName, !firstName.isEmpty {
            updatedFields["firstName"] = firstName
        }
        
        if let lastName = lastName, !lastName.isEmpty {
            updatedFields["lastName"] = lastName
        }
        
        func fetchAndReturnUser() {
            userRef.getDocument { document, error in
                if let document = document, let data = document.data(), let userModel = UserModel(dictionary: data) {
                    completion(.success(userModel))
                } else {
                    completion(.failure(error ?? NSError(domain: "Failed to fetch user", code: 500)))
                }
            }
        }
        
        if !updatedFields.isEmpty {
            userRef.updateData(updatedFields) { error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let newPassword = newPassword, !newPassword.isEmpty {
                    user.updatePassword(to: newPassword) { error in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            fetchAndReturnUser()
                        }
                    }
                } else {
                    fetchAndReturnUser()
                }
            }
        } else if let newPassword = newPassword, !newPassword.isEmpty {
            user.updatePassword(to: newPassword) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    fetchAndReturnUser()
                }
            }
        } else {
            fetchAndReturnUser()
        }
    }
    
}
