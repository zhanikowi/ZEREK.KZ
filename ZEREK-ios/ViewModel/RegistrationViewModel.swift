//
//  RegistrationViewModel.swift
//  ZEREK-ios
//
//  Created by bakebrlk on 07.03.2025.
//

import SwiftUI

final class RegistrationViewModel: ObservableObject {
    private init() {}
    public static var shared: RegistrationViewModel = RegistrationViewModel()
    
    @Published public var isSigningUp: Bool = false
    
    @Published public var info: RegistrationModel =
    RegistrationModel(
        oldYear: "",
        level: "",
        purpose: "",
        email: "",
        password: "",
        firstName: "",
        lastName: ""
    )
    
    @Published public var isSecure: Bool = true
    @Published public var confirmPassword: String = ""
    
    public func didTapSignUp() async -> Bool {
        await MainActor.run { self.isSigningUp = true }

        defer {
            Task { @MainActor in self.isSigningUp = false }
        }

        do {
            guard let user = try await ServerManager.signUp(
                email: info.email,
                password: info.password,
                user: UserModel(
                    id: UUID().uuidString,
                    firstName: info.firstName,
                    lastName: info.lastName,
                    email: info.email,
                    languageLevel: info.level,
                    age: info.oldYear,
                    purpose: info.purpose,
                    completedUnits: [],
                    rank: 0,
                    activityDays: [],
                    lastActiveDate: Date.now,
                    money: 50,
                    life: 5
                )
            ) else {
                return false
            }

            try await ServerManager.createNewUser(userInfo: user)
            return true
        } catch {
            return false
        }
    }


    public func didTapLogin() async -> Bool {
        do {
            guard (try await ServerManager.login(email: info.email, password: info.password)) != nil else { return false }
            return true
        } catch {
            return false
        }
    }
}
