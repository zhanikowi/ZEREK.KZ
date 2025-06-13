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
    
    static func signUp(email: String, password: String, user: UserModel) async throws -> UserModel? {
        
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
        _ = try await Auth.auth().signIn(withEmail: email, password: password)
        
        let user = try await asyncFetchUser()
        return user
    }

       
    public static func asyncFetchUser() async throws -> UserModel? {
        guard let email = Auth.auth().currentUser?.email else {
            return nil
        }

        return try await withCheckedThrowingContinuation { continuation in
            let db = Firestore.firestore()
            db.collection("users").whereField("email", isEqualTo: email).getDocuments { snapshot, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let document = snapshot?.documents.first else {
                    continuation.resume(returning: nil)
                    return
                }

                do {
                    let user = try document.data(as: UserModel.self)
                    continuation.resume(returning: user)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    
    public static func signOut() throws {
        try Auth.auth().signOut()
    }
    
    static func resetPassword(email: String) async throws {
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
            "purpose" : userInfo.purpose,
            "completedUnits" : userInfo.completedUnits,
            "rank" : userInfo.rank,
            "activityDays" : userInfo.activityDays,
            "lastActiveDate" : userInfo.lastActiveDate,
            "money" : userInfo.money,
            "life" : userInfo.life
        ]
        
        try await Firestore.firestore().collection("users").document(userInfo.email).setData(userData, merge: false)
    }
    
    private static let db = Firestore.firestore()
    
    static func asyncFetchUnits() async throws -> [UnitsModel] {
        let unitNames = ["Unit1", "Unit2", "Unit3", "Unit4", "Unit5"]
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
        
        return parseUnitData(result, unitNames: unitNames)
    }
    
    static func parseUnitData(_ rawUnits: [String: [String: [String: Any]]], unitNames: [String]) -> [UnitsModel] {
        unitNames.enumerated().compactMap { index, unitKey in
            guard let documents = rawUnits[unitKey] else { return nil }
            
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
            
            return UnitsModel(
                iconName: unitKey,
                title: "UNITS",
                description: "UNITS",
                queue: index,
                units: [
                    Units(
                        fillText: fillText,
                        finishSentence: finishSentence,
                        correctTranslations: correctTranslations,
                        makeSentence: makeSentence
                    )
                ]
            )
        }
    }
    
    static func updateUserData(
        firstName: String?,
        lastName: String?,
        newPassword: String?,
        completion: @escaping (Result<UserModel, Error>) -> Void
    ) {
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "No user", code: 401)))
            return
        }
        
        guard let userEmail = user.email else {
            completion(.failure(NSError(domain: "No user email", code: 401)))
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
        
        func finishWithUserData() {
            userRef.getDocument { document, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = document?.data() else {
                    completion(.failure(NSError(domain: "No user data", code: 404)))
                    return
                }
                
                do {
                    let userModel = try Firestore.Decoder().decode(UserModel.self, from: data)
                    completion(.success(userModel))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        let updatePasswordIfNeeded: (@escaping () -> Void) -> Void = { next in
            if let newPassword = newPassword, !newPassword.isEmpty {
                user.updatePassword(to: newPassword) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        next()
                    }
                }
            } else {
                next()
            }
        }
        
        if !updatedFields.isEmpty {
            userRef.updateData(updatedFields) { error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                updatePasswordIfNeeded {
                    finishWithUserData()
                }
            }
        } else {
            updatePasswordIfNeeded {
                finishWithUserData()
            }
        }
    }
    
    static func fetchCompletedUnitKeys(email: String) async throws -> [String] {
        let doc = try await Firestore.firestore().collection("users").document(email).getDocument()
        return doc.data()?["completedUnits"] as? [String] ?? []
    }
    
    static func updateCompletedUnits(completed: [String], moneyToAdd: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let email = Auth.auth().currentUser?.email else {
            completion(.failure(NSError(domain: "No user email", code: 401)))
            return
        }

        let userRef = Firestore.firestore().collection("users").document(email)

        userRef.getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = snapshot?.data(),
                  var currentCoins = data["money"] as? Int else {
                completion(.failure(NSError(domain: "Failed to read user data", code: 500)))
                return
            }

            currentCoins += moneyToAdd

            let payload: [String: Any] = [
                "completedUnits": completed,
                "money": currentCoins
            ]

            userRef.updateData(payload) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    }

    
    static func fetchActivityDays(email: String) async throws -> [String] {
        let doc = try await Firestore.firestore().collection("users").document(email).getDocument()
        return doc.data()?["activityDays"] as? [String] ?? []
    }

    static func updateActivityDays(_ days: [String], completion: @escaping (Result<Void, Error>) -> Void) {
        let payload = ["activityDays": days]
        Firestore.firestore().collection("users")
            .document(Auth.auth().currentUser?.email ?? "")
            .updateData(payload) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }
    
    static func fetchRatingUsers() async throws -> [UserRatingModel] {
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        
        let users: [UserModel] = try snapshot.documents.compactMap { doc in
            try doc.data(as: UserModel.self)
        }
        
        let sortedUsers = users.sorted { $0.points > $1.points }
        
        return sortedUsers.enumerated().map { index, user in
            UserRatingModel(
                rank: index + 1,
                name: user.firstName,
                photo: "defaultPhoto",
                score: user.points
            )
        }
    }
    
    static func fetchVideoCallHistory() async throws -> [VideoCallModel] {
        let snapshot = try await Firestore.firestore().collection("videoCall").document("callHistory").getDocument()
        
        let callHistory: [String: String] = try snapshot.data(as: [String: String].self)
            
        var videoCallHistory: [VideoCallModel] = []
        
        for (mentor, duration) in callHistory {
            videoCallHistory.append(VideoCallModel(callName: mentor, callDuration: duration))
        }
        
        return videoCallHistory
    }
    
    static func fetchAudioDictionaryWords(completion: @escaping (Result<[AudioDictionaryModel], Error>) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("dictionary").document("words")
        
        docRef.getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = snapshot?.data() as? [String: String] else {
                completion(.failure(NSError(domain: "Invalid data format", code: 0)))
                return
            }
            
            let words = data.map { key, value in
                AudioDictionaryModel(word: value, translation: key, audioFileName: "\(key).mp3")
            }
            
            completion(.success(words))
        }
    }
    
    static func deductMoney(amount: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let email = Auth.auth().currentUser?.email else {
            completion(.failure(NSError(domain: "No user email", code: 401)))
            return
        }

        let userRef = Firestore.firestore().collection("users").document(email)

        userRef.getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = snapshot?.data(),
                  var currentMoney = data["money"] as? Int else {
                completion(.failure(NSError(domain: "Failed to read money", code: 500)))
                return
            }
            
            currentMoney -= amount
            currentMoney = max(currentMoney, 0)
            
            userRef.updateData(["money": currentMoney]) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    }
    
    static func deleteAccount(password: String, email: String) async throws {
        let user = Auth.auth().currentUser
        
        guard let email = user?.email else {
            throw NSError(domain: "No current user", code: 401, userInfo: nil)
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        try await user?.reauthenticate(with: credential)
        
        try await db.collection("users").document(email).delete()
        
        try await user?.delete()
    }
}
