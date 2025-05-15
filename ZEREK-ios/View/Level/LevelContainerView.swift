//
//  LevelContainerView.swift
//  ZEREK
//
//  Created by  Admin on 08.05.2025.
//

import SwiftUI

enum LevelType: Int, CaseIterable {
    case selectTranslate
    case putWord
    case selectSentence
    case fill
    case respect
    
    var next: LevelType? {
        let all = LevelType.allCases
        guard let currentIndex = all.firstIndex(of: self),
              currentIndex + 1 < all.count else { return nil }
        return all[currentIndex + 1]
    }
}

struct LevelContainerView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var currentLevel: LevelType = .selectTranslate
    @State private var progress: Double = 0.25
    
    private func goToNextLevel() {
        if let next = currentLevel.next {
            currentLevel = next
            progress += 0.25
        } else {
            print("Game Finished")
        }
    }
    
    var body: some View {
        VStack {
            Constant.navigationHealthBar(progressValue: progress, health: 5) {
                dismiss()
            }
            
            switch currentLevel {
            case .selectTranslate:
                LevelSelectTranslateView(onContinue: goToNextLevel)
            case .putWord:
                LevelPutWordView(onContinue: goToNextLevel)
            case .selectSentence:
                LevelSelectAllSentenceView(onContinue: goToNextLevel)
            case .fill:
                LevelFillView(onContinue: goToNextLevel)
            case .respect:
                RespectView()
            }
        }
        .animation(.easeInOut, value: currentLevel)
    }
}
