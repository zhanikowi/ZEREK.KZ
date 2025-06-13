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
    @Published var callHistory: [VideoCallModel] = []
    @Published var isLoading = false
    
    init() {
        Task {
            await fetchCallHistory()
        }
    }
    
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
    
    func fetchCallHistory() async {
        await MainActor.run {
            self.isLoading = true
        }
        
        do {
            let result = try await ServerManager.fetchVideoCallHistory()
            await MainActor.run {
                self.callHistory = result
            }
        } catch {
            print("❌ Ошибка при загрузке рейтинга: \(error.localizedDescription)")
        }
        
        await MainActor.run {
            self.isLoading = false
        }
    }
}
