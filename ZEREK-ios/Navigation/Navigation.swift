//
//  Navigation.swift
//  ZEREK-ios
//
//  Created by bakebrlk on 22.03.2025.
//

import SwiftUI

final class Navigation: ObservableObject {
    
    public enum Destination: Hashable {
        case welcome
        case signIn
        case createAccount
        case createPassword
        case selectAge
        case selectElevel
        case selectPurpose
        case start
        case privacy
        case settings
        case editAccount
        case deleteAccount
        case notification
        case notificationMessages
        case tabBar
        
        @ViewBuilder
        func getView() -> some View {
            Group {
                switch self {
                case .welcome:
                    WelcomeView()
                case .signIn:
                    LoginView()
                case .createAccount:
                    CreateAccountView()
                case .createPassword:
                    CreatePasswordView()
                case .selectAge:
                    RegistryOldView()
                case .selectElevel:
                    RegistryLevelView()
                case .selectPurpose:
                    RegistryPurposeView()
                case .start:
                    StartView()
                case .privacy:
                    PrivacyView()
                case .settings:
                    SettingsView()
                case .editAccount:
                    EditAccountView()
                case .deleteAccount:
                    DeleteAccountView()
                case .notification:
                    NotificationsView()
                case .notificationMessages:
                    NotificationView()
                case .tabBar:
                    TabBarView()
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
    
    func setTabBarAsRoot() {
        navPath = NavigationPath()
        navPath.append(Destination.tabBar)
    }
}
