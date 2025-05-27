//
//  MainViewModel.swift
//  ZEREK
//
//  Created by bakebrlk on 28.03.2025.
//

import SwiftUI

@MainActor
final class MainViewModel: ObservableObject {
    @AppStorage("showed_onboarding_key") public var showedOnboarding: Bool = false
    @Published public var page: Page = .home
    @Published public var user: UserModel = UserModel()
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var allunits: [UnitsModel] = []
    
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
    
    @Published public var levelProgressValue: CGFloat = 0.1
    @Published public var respectText: String = "Keep going!"
    
    var isAuthorized: Bool {
        !user.firstName.isEmpty || !user.lastName.isEmpty
    }
}

extension MainViewModel {    
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
    
    func fetchUnits() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let units = try await ServerManager.asyncFetchUnits()
            let allunits = [
                UnitsModel(iconName: "Unit1", title: "UNITS", description: "HERE ALL UNITS", queue: 1, units: units),
                UnitsModel(iconName: "Unit2", title: "UNITS", description: "HERE ALL UNITS", queue: 2, units: units),
                UnitsModel(iconName: "Unit3", title: "UNITS", description: "HERE ALL UNITS", queue: 3, units: units),
                UnitsModel(iconName: "Unit4", title: "UNITS", description: "HERE ALL UNITS", queue: 4, units: units),
                UnitsModel(iconName: "Unit5", title: "UNITS", description: "HERE ALL UNITS", queue: 5, units: units)
            ]
            self.allunits = allunits
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
