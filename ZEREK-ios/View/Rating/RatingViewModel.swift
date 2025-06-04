//
//  RatingViewModel.swift
//  ZEREK
//
//  Created by  Admin on 01.06.2025.
//

import SwiftUI

final class RatingViewModel: ObservableObject {
    @Published var userRatings: [UserRatingModel] = []
    
    @Published var isLoading = false
    
    init() {
        Task {
            await fetchRatings()
        }
    }
    
    func fetchRatings() async {
        await MainActor.run {
            self.isLoading = true
        }
        
        do {
            let result = try await ServerManager.fetchRatingUsers()
            await MainActor.run {
                self.userRatings = result
            }
        } catch {
            print("❌ Ошибка при загрузке рейтинга: \(error.localizedDescription)")
        }
        
        await MainActor.run {
            self.isLoading = false
        }
    }

}
