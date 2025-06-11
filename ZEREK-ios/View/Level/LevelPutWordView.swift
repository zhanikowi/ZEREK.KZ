//
//  LevelPutWordView.swift
//  ZEREK
//
//  Created by bakebrlk on 04.04.2025.
//

import SwiftUI

struct LevelPutWordView: View {
    let item: FinishSentenceItem
    var onContinue: () -> Void
    var onWrong: () -> Void

    @State private var selectedWord: String = ""
    @State private var showAnswer: Bool = false

    // MARK: UI Components

    private var title: some View {
        Constant.getText(text: "Finish the sentence", font: .bold, size: 24)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, Constant.radius * 2)
            .padding(.horizontal, Constant.radius)
    }

    private var image: some View {
        Image("koiLevels").configure
            .frame(maxWidth: Constant.width * 0.57)
            .padding(Constant.radius)
            .padding(.top, Constant.radius)
    }

    private var textsView: some View {
        VStack(alignment: .leading, spacing: Constant.radius / 2) {
            Constant.getText(text: item.question, font: .regular, size: 20)
                .padding(Constant.radius)

            if selectedWord != "" {
                Constant.getText(text: selectedWord, font: .regular, size: 20)
                    .padding(Constant.radius / 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: Constant.radius)
                            .stroke(Constant.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, Constant.radius)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var words: some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]

        return LazyVGrid(columns: columns) {
            ForEach(item.options, id: \.self) { word in
                Button {
                    withAnimation {
                        selectedWord = (selectedWord == word) ? "" : word
                    }
                } label: {
                    Text(word)
                        .frame(maxWidth: Constant.width / 4)
                        .padding(.horizontal, Constant.radius / 4)
                        .padding(.vertical, Constant.radius * 0.2)
                        .background(
                            RoundedRectangle(cornerRadius: Constant.radius / 1.5)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                        .foregroundColor(.black)
                        .padding(.top, Constant.radius * 0.5)
                }
            }
        }
        .padding(.horizontal, Constant.radius)
    }
    
    private var continueButton: some View {
        Button(action: {
            if showAnswer {
                if selectedWord == item.options[item.correctIndex] {
                    onContinue()
                } else {
                    onWrong()
                }
            } else {
                showAnswer = true
            }
        }) {
            Text("Continue")
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
        }
        .background(
            showAnswer
            ? (selectedWord == item.options[item.correctIndex] ? Constant.purple : Color.red)
            : (selectedWord != "" ? Constant.purple : Constant.gray)
        )
        .cornerRadius(Constant.radius / 2)
        .padding(.bottom, Constant.radius)
        .padding(.horizontal, Constant.radius)
    }

    private var answerView: some View {
        VStack {
            if selectedWord == item.options[item.correctIndex] {
                HStack {
                    Image(systemName: "checkmark.circle.fill").configure
                        .frame(width: Constant.width * 0.085, height: Constant.width * 0.085)

                    Constant.getText(text: "Good job!", font: .bold, size: 24)
                    Spacer()
                }
            } else {
                HStack {
                    Constant.getText(text: "Right answer:", font: .bold, size: 24)
                    Constant.getText(text: item.options[item.correctIndex], font: .regular, size: 24)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            Spacer()
        }
        .padding(.top, Constant.radius)
        .padding(.horizontal, Constant.radius)
        .foregroundColor(selectedWord == item.options[item.correctIndex] ? Constant.purple : Color.red)
        .background(
            (selectedWord == item.options[item.correctIndex]
                ? Constant.purple.opacity(0.4)
                : Color.red.opacity(0.4))
        )
    }

    // MARK: - Body

    var body: some View {
        VStack {
            title
            image
            textsView
            words

            Spacer()

            ZStack {
                if showAnswer {
                    answerView
                        .cornerRadius(24)
                }
                continueButton
                    .padding(.top, Constant.width * 0.2)
            }
            .frame(maxWidth: .infinity, maxHeight: Constant.width * 0.4)
        }
    }
}
