//
//  VideoCallViewModel.swift
//  ZEREK
//
//  Created by  Admin on 01.06.2025.
//

import Foundation
import SwiftUI

@MainActor
class VideoCallViewModel: ObservableObject {
    @Published var currentUser: UserModel?
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func loadUser() async {
        do {
            currentUser = try await ServerManager.asyncFetchUser()
        } catch {
            alertMessage = "Failed to load user."
            showAlert = true
        }
    }
    
    func tryToStartCall(phoneNumber: String, onSuccess: @escaping () -> Void) {
        guard let money = currentUser?.money else {
            alertMessage = "User data unavailable."
            showAlert = true
            return
        }

        if money < 50 {
            alertMessage = "Not enough funds to make a call. Need at least 50 coins."
            showAlert = true
        } else {
            onSuccess()
            deductMoneyAfterCall()
        }
    }

    private func deductMoneyAfterCall() {
        ServerManager.deductMoney(amount: 50) { [weak self] result in
            switch result {
            case .success:
                Task { await self?.loadUser() }
            case .failure(let error):
                self?.alertMessage = "Error writing off coins: \(error.localizedDescription)"
                self?.showAlert = true
            }
        }
    }
}
