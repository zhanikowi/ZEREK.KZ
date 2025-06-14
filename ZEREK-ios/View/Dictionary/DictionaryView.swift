//
//  DictionaryView.swift
//  ZEREK
//
//  Created by  Admin on 06.05.2025.
//

import SwiftUI

struct DictionaryView: View {
    var onAllCardsRemoved: () -> Void
    @Environment(\.dismiss) private var dismiss
    
    @State private var words: [AudioDictionaryModel]
    @State private var initialCardsCount: Int = 0
    @State private var progressValue: CGFloat = 0.0
    
    init(words: [AudioDictionaryModel], onAllCardsRemoved: @escaping () -> Void) {
        self._words = State(initialValue: words)
        self.onAllCardsRemoved = onAllCardsRemoved
    }

    var body: some View {
        VStack(spacing: 16) {
            navigationProgressBar(
                progressValue: progressValue,
                action: {
                    dismiss()
                }
            )
            .padding(.top, 20)
            
            Spacer()
            
            ZStack {
                ForEach(Array(words.enumerated()), id: \.element.id) { (offsetIndex, card) in
                    DictionaryCardView(
                        card: card,
                        onRemove: {
                            removeCard(at: offsetIndex)
                        }
                    )
                    .offset(y: CGFloat(offsetIndex) * 5)
                }
            }
            
            Spacer()
            
            Image("swipeHint")
                .resizable()
                .frame(width: 300, height: 85)
            
            Spacer()
        }
        .onAppear {
            if initialCardsCount == 0 {
                initialCardsCount = words.count
            }
        }
    }
    
    private func removeCard(at index: Int) {
        guard !words.isEmpty else { return }

        words.remove(at: index)

        if initialCardsCount > 0 {
            let removedCount = initialCardsCount - words.count
            progressValue = CGFloat(removedCount) / CGFloat(initialCardsCount)
        }

        if words.isEmpty {
            onAllCardsRemoved()
        }
    }
}


extension DictionaryView {
    public func navigationProgressBar(progressValue: CGFloat, action: @escaping () -> Void) -> some View {
        HStack {
            closeButton(action: action)
            progressView(progressValue: progressValue)
        }
        .padding(.horizontal)
    }
    
    private func progressView(progressValue : CGFloat) -> some View {
        LinearProgressView(value: progressValue, shape: Capsule())
            .tint(Constant.purple)
            .frame(maxWidth: .infinity, maxHeight: 8)
            .padding(.horizontal, 4)
    }
    
    private func closeButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundColor(.primary)
        }
    }
}
