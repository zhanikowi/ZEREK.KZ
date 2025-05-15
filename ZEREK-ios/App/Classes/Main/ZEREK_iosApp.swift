//
//  ZEREK_iosApp.swift
//  ZEREK-ios
//
//  Created by bakebrlk on 07.03.2025.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct ZEREK_iosApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @ObservedObject var navigation = Navigation()
    @ObservedObject var registryViewModel: RegistryViewModel = RegistryViewModel.shared
    @ObservedObject var mainViewModel: MainViewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigation.navPath) {
                Group {
                    if mainViewModel.showedOnboarding {
                        TabBarView()
                    } else {
                        WelcomeView()
                    }
                }
                .navigationDestination(for: Navigation.Destination.self) { destination in
                    destination.getView()
                }
            }
            .environmentObject(navigation)
            .environmentObject(registryViewModel)
            .environmentObject(mainViewModel)
        }
    }
}
