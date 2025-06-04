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
    let unitModel: UnitsModel
    
    private var unit: Units {
        unitModel.units.first!
    }
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var viewModel: MainViewModel
    
    @State private var currentLevel: LevelType = .selectTranslate
    @State private var progress: Double = 0.25
    @State private var showOutOfLivesAlert: Bool = false
    
    private func goToNextLevel() {
        if let next = currentLevel.next {
            if next == .respect {
                viewModel.completeUnit(unitModel)
            }
            currentLevel = next
            progress += 0.25
        } else {
            print("Game Finished")
        }
    }

    var body: some View {
        ZStack {
            VStack {
                Constant.navigationHealthBar(progressValue: progress, health: viewModel.lives) {
                    dismiss()
                }
                
                switch currentLevel {
                case .selectTranslate:
                    if let item = unit.correctTranslations.first {
                        LevelSelectTranslateView(item: item, onContinue: goToNextLevel, onWrong: viewModel.loseLife)
                    }
                case .putWord:
                    if let item = unit.finishSentence.first {
                        LevelPutWordView(item: item, onContinue: goToNextLevel)
                    }
                case .selectSentence:
                    if let item = unit.makeSentence.first {
                        LevelSelectAllSentenceView(item: item, onContinue: goToNextLevel)
                    }
                case .fill:
                    if let item = unit.fillText.first {
                        LevelFillView(item: item, onContinue: goToNextLevel)
                    }
                case .respect:
                    RespectView()
                }
            }
            .onReceive(viewModel.$isOutOfLives) { isOut in
                if isOut {
                    showOutOfLivesAlert = true
                }
            }
            if showOutOfLivesAlert {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                
                CustomAlertView(
                    title: "No lives left!",
                    message: "Try the level again.",
                    buttonTitle: "OK"
                ) {
                    withAnimation {
                        viewModel.resetLives()
                        showOutOfLivesAlert = false
                        dismiss()
                    }
                }
                .transition(.scale)
            }
        }
        .animation(.easeInOut, value: showOutOfLivesAlert)
        .animation(.easeInOut, value: currentLevel)
    }
}
