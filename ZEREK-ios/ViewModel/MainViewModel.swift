//
//  MainViewModel.swift
//  ZEREK
//
//  Created by bakebrlk on 28.03.2025.
//

import SwiftUI
import Combine

@MainActor
final class MainViewModel: ObservableObject {
    @AppStorage("showed_onboarding_key") public var showedOnboarding: Bool = false
    @Published public var page: Page = .home
    @Published public var user: UserModel = UserModel()
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var units: [UnitsModel] = []
    @Published var completedUnitKeys: Set<String> = []
        
    @Published public var respectText: String = "Keep going!"

    @Published public var lives: Int = 5
    @Published public var isOutOfLives: Bool = false
    
    public func loseLife() {
        if lives > 1 {
            lives -= 1
        } else {
            lives = 0
            isOutOfLives = true
        }
    }
    
    public func resetLives() {
        lives = 5
        isOutOfLives = false
    }
}

extension MainViewModel {
    func loadInitialData() async {
        isLoading = true
        errorMessage = nil

        do {
            let fetchedUser = try await ServerManager.asyncFetchUser()
            self.user = fetchedUser ?? UserModel()
            self.completedUnitKeys = Set(self.user.completedUnits)

            let fetchedUnits = try await ServerManager.asyncFetchUnits()
            self.units = fetchedUnits
            self.isLoading = false
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }

    func fetchUser() async {
        do {
            let fetchedUser = try await ServerManager.asyncFetchUser()
            self.user = fetchedUser ?? UserModel()
            self.completedUnitKeys = Set(self.user.completedUnits)
        } catch {
            print("Failed to fetch user: \(error)")
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
            
            self.units = units
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func completeUnit(_ unit: UnitsModel) {
        let unitKey = unit.iconName

        guard !user.completedUnits.contains(unitKey) else { return }

        user.completedUnits.append(unitKey)
        completedUnitKeys.insert(unitKey)
        user.money += 10

        ServerManager.updateCompletedUnits(
            completed: user.completedUnits,
            moneyToAdd: 10
        ) { result in
            switch result {
            case .success:
                print("✅ Completed units and coins updated")
            case .failure(let error):
                print("❌ Failed to update data:", error.localizedDescription)
            }
        }
    }

}
