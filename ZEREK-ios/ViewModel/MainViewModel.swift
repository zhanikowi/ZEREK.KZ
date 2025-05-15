//
//  MainViewModel.swift
//  ZEREK
//
//  Created by bakebrlk on 28.03.2025.
//

import SwiftUI

final class MainViewModel: ObservableObject {
    @AppStorage("showed_onboarding_key") public var showedOnboarding: Bool = false
    @Published public var page: Page = .home
    @Published public var user: UserModel = UserModel()
    
    @Published public var units: [UnitModel] = [
        UnitModel(title: 1, description: "Everyday Basics", levels: [
            LevelModel(image: "l1", words: [LevelTest(words: "кітап"), LevelTest(words: "жасыл"), LevelTest(words: "екі"), LevelTest(words: "зерек"), LevelTest(words: "жасыл"), LevelTest(words: "жасыл")], sentence: "", answer: "зерек", fillText: "Бұл менің  _______ ."),
            LevelModel(image: "l2", words:[LevelTest(words: "кітап"), LevelTest(words: "жасыл"), LevelTest(words: "екі"), LevelTest(words: "зерек"), LevelTest(words: "жасыл"), LevelTest(words: "жасыл")], sentence: "", answer: "зерек", fillText: "Бұл менің  _______ ."),
            LevelModel(image: "l3", words:[LevelTest(words: "кітап"), LevelTest(words: "жасыл"), LevelTest(words: "екі"), LevelTest(words: "зерек"), LevelTest(words: "жасыл"), LevelTest(words: "жасыл")], sentence: "", answer: "зерек", fillText: "Бұл менің  _______ ."),
            LevelModel(image: "l4", words:[LevelTest(words: "кітап"), LevelTest(words: "жасыл"), LevelTest(words: "екі"), LevelTest(words: "зерек"), LevelTest(words: "жасыл"), LevelTest(words: "жасыл")], sentence: "", answer: "зерек", fillText: "Бұл менің  _______ ."),
            LevelModel(image: "l5", words: [LevelTest(words: "кітап"), LevelTest(words: "жасыл"), LevelTest(words: "екі"), LevelTest(words: "зерек"), LevelTest(words: "жасыл"), LevelTest(words: "жасыл")], sentence: "", answer: "зерек", fillText: "Бұл менің  _______ ."),
        ],
                  imageName: "4"
                 )
    ]
    
    @Published public var isLeft: Bool = true
    @Published public var paddingValue: CGFloat = 0
    
    // MARK: Rating
    @Published public var users: [UserRatingModel] = [
        UserRatingModel(rank: 1, name: "Arman", photo: "defaultPhoto", score: 100),
        UserRatingModel(rank: 2, name: "Bolat", photo: "defaultPhoto", score: 90),
        UserRatingModel(rank: 3, name: "Aru", photo: "defaultPhoto", score: 70),
        UserRatingModel(rank: 4, name: "Kanat", photo: "defaultPhoto", score: 50),
        UserRatingModel(rank: 5, name: "Arnur", photo: "defaultPhoto", score: 20),
        UserRatingModel(rank: 6, name: "Zhan", photo: "defaultPhoto", score: 0)
    ]
    @Published public var selectLevel: LevelModel? = LevelModel(image: "l4", words:[LevelTest(words: "кітап"), LevelTest(words: "жасыл"), LevelTest(words: "екі"), LevelTest(words: "зерек"), LevelTest(words: "жасыл"), LevelTest(words: "жасыл")], sentence: "Excuse me, do you have a toothpaste ?", answer: "зерек", fillText: "Бұл менің")
    
    @Published public var levelProgressValue: CGFloat = 0.1
    @Published public var selectedWord: String = "Зерек"
    
    @Published public var respectText: String = "Keep going!"
    
    var isAuthorized: Bool {
        !user.firstName.isEmpty || !user.lastName.isEmpty
    }
}

extension MainViewModel {
    public func fetchUnit() {
        ServerManager.fetchUnit(unitID: "Unit1") { units in
            DispatchQueue.main.async {
                print(units)
            }
        }
    }
    
    public func fetchUser() {
        ServerManager.fetchUser() { fetchedUser in
            DispatchQueue.main.async { [self] in
                user = fetchedUser != nil ? fetchedUser! : UserModel()
            }
        }
    }
    
    public func updateUserData(name: String, surename: String, password: String) {
        ServerManager.updateUserData(firstName: name, lastName: surename, newPassword: password) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async { [self] in
                    user = success
                }
            case .failure(let failure):
                print("Error in update User: ", failure.localizedDescription)
            }
        }
    }
    
    public func signOut() {
        Task {
            try ServerManager.signOut()
        }
    }
}
