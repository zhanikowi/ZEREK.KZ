//
//  RegistryViewModel.swift
//  ZEREK-ios
//
//  Created by bakebrlk on 07.03.2025.
//

import SwiftUI

final class RegistryViewModel: ObservableObject {
    private init() {}
    public static var shared: RegistryViewModel = RegistryViewModel()
    
    @Published public var info: RegistrationModel = RegistrationModel(oldYear: "",
                                                              level: "",
                                                              purpose: "",
                                                              email: "",
                                                              password: "",
                                                              firstName: "",
                                                              lastName: "")
    
    @Published public var isSecure: Bool = true
    @Published public var confirmPassword: String = ""
    
    public func didTapSignUp() async -> Bool {
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
                    purpose: info.purpose
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
            guard let user = try await ServerManager.login(email: info.email, password: info.password) else {return false}
            DispatchQueue.main.async { [self] in
                info.firstName = user.firstName
            }
            return true
        }catch {
            return false
        }
    }
}
