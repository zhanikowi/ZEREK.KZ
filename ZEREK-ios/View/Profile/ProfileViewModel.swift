//
//  ProfileViewModel.swift
//  ZEREK
//
//  Created by  Admin on 01.06.2025.
//

import SwiftUI
import FirebaseAuth

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var completedUnits: [String] = []
    @Published var activityDays: [String] = []
    @Published var isLoading = false
    @Published var user = UserModel()
    
    @Published var achievements = [
        UserAchievements(title: "Smooth Talker", imageName: "GlowingStar"),
        UserAchievements(title: "Daily Streak Keeper", imageName: "Trophy"),
        UserAchievements(title: "Fast learner", imageName: "Warranty")
    ]
    
    private let email: String?
    
    init() {
        self.email = Auth.auth().currentUser?.email
    }
    
    var isAuthorized: Bool {
        return Auth.auth().currentUser != nil
    }
    
    var userName: String {
        return "\(user.firstName) \(user.lastName)"
    }
    
    var languageLevel: String {
        return user.languageLevel
    }
    
    var levelProgress: Double {
        return Double(completedUnits.count) / 5.0
    }
    
    var money: Int {
        return user.money
    }
    
    func getLast7Days() -> [String] {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.locale = Locale(identifier: "en_US")
        
        let today = Date()
        return (0..<7).map {
            let date = Calendar.current.date(byAdding: .day, value: -$0, to: today)!
            return formatter.string(from: date)
        }.reversed()
    }
    
    func fetchUserProfile() async {
        self.isLoading = true
        
        do {
            guard let fetchedUser = try await ServerManager.asyncFetchUser() else { return }
            self.user = fetchedUser
            self.isLoading = false
        } catch {
            print("Error fetching user profile: \(error)")
            self.isLoading = false
        }
    }
    
    func fetchCompletedAndActivityDays() async {
        guard let email = email else { return }
        
        self.isLoading = true
        
        do {
            async let completed = try ServerManager.fetchCompletedUnitKeys(email: email)
            async let activity = try ServerManager.fetchActivityDays(email: email)
            
            let completedResult = try await completed
            let activityResult = try await activity
            
            self.completedUnits = completedResult
            self.activityDays = activityResult
            self.isLoading = false
        } catch {
            print("Error fetching user progress: \(error)")
            self.isLoading = false
        }
    }
    
    func updateActivityDaysIfNeeded() {
        let today = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        
        guard !activityDays.contains(today) else { return }
        
        activityDays.append(today)
        ServerManager.updateActivityDays(activityDays) { result in
            switch result {
            case .success(): break
            case .failure(let error):
                print("Error updating activity days: \(error)")
            }
        }
    }
}
