//
//  LevelFillView.swift
//  ZEREK
//
//  Created by bakebrlk on 09.04.2025.
//

import SwiftUI

struct LevelFillView: View {
    var item: FillTextItem
    var onContinue: () -> Void
    var onWrong: () -> Void

    @State private var showAnswer: Bool = false
    @State private var answer: String = ""

    private var title: some View {
        Constant.getText(text: "Fill in the text", font: .bold, size: 24)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, Constant.radius * 2)
            .padding(.horizontal, Constant.radius)
    }

    private var image: some View {
        Image("koiJuu").configure
            .frame(maxWidth: Constant.width * 0.57, maxHeight: Constant.width * 0.57)
            .padding(Constant.radius)
            .padding(.top, Constant.radius)
    }

    private var continueButton: some View {
        Button(action: {
            if showAnswer {
                if answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == item.correct.lowercased() {
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
            ? (answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == item.correct.lowercased()
                ? Constant.purple
                : Color.red)
            : (!answer.isEmpty ? Constant.purple : Constant.gray)
        )
        .cornerRadius(Constant.radius / 2)
        .padding(.bottom, Constant.radius)
        .padding(.horizontal, Constant.radius)
    }

    private var answerView: some View {
        VStack {
            if answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == item.correct.lowercased() {
                HStack {
                    Image(systemName: "checkmark.circle.fill").configure
                        .frame(width: Constant.width * 0.085, height: Constant.width * 0.085)

                    Constant.getText(text: "Good job!", font: .bold, size: 24)
                    Spacer()
                }
            } else {
                HStack {
                    Constant.getText(text: "Right answer:", font: .bold, size: 24)
                    Constant.getText(text: item.correct, font: .regular, size: 24)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            Spacer()
        }
        .padding(.top, Constant.radius)
        .padding(.horizontal, Constant.radius)
        .foregroundColor(answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == item.correct.lowercased()
                         ? Constant.purple
                         : Color.red)
        .background(answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == item.correct.lowercased()
                    ? Constant.purple.opacity(0.4)
                    : Color.red.opacity(0.4))
    }

    private var fillText: some View {
        HStack(spacing: 4) {
            Constant.getText(text: item.question, font: .regular, size: 20)
            TextField("_____.", text: $answer)
                .frame(maxWidth: 75)
        }
        .frame(maxWidth: .infinity, alignment: .bottomLeading)
        .padding(.leading, 16)
    }

    var body: some View {
        VStack {
            title
            image
            fillText

            Spacer()

            ZStack {
                if showAnswer {
                    answerView
                        .cornerRadius(24)
                }
                VStack {
                    Spacer()
                    continueButton
                }
            }
            .frame(maxWidth: .infinity, maxHeight: Constant.width * 0.4)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    LevelFillView(
        item: FillTextItem.init(
            question: "Уақытты көрсететін құрал - ",
            correct: "қолым"
        ),
        onContinue: {
            print("✅ Correct answer, continue tapped.")
        },
        onWrong: {
            print("❌ Wrong answer, continue tapped.")
        }
    )
}
