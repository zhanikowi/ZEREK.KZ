//
//  LevelSelectTranslateView.swift
//  ZEREK
//
//  Created by bakebrlk on 02.04.2025.
//

import SwiftUI

struct LevelSelectTranslateView: View {
    let item: CorrectTranslationsItem
    var onContinue: () -> Void
    var onWrong: () -> Void
    
    @State private var selectedAnswer: Int?
    @State private var showAnswer: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constant.radius) {
            Constant.getText(text: "Read and choose the correct translation", font: .bold, size: 24)
                .padding(.top, Constant.radius)
                .padding(.horizontal, Constant.radius)
            
            Constant.getText(text: item.question, font: .bold, size: Constant.radius)
                .padding(.bottom, Constant.radius)
                .padding(.horizontal, Constant.radius)
            
            ForEach(0..<item.options.count, id: \.self) { index in
                Button(action: {
                    selectedAnswer = index
                }) {
                    HStack {
                        Text(item.options[index])
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(selectedAnswer == index ? Constant.gold.opacity(0.4) : Color.clear)
                    .overlay {
                        RoundedRectangle(cornerRadius: Constant.radius / 2)
                            .stroke(selectedAnswer == index ? Constant.black : Constant.gray.opacity(0.3), lineWidth: 1)
                    }
                    .cornerRadius(Constant.radius / 2)
                }
                .padding(.horizontal, Constant.radius)
            }
            
            Spacer()
            ZStack {
                if showAnswer {
                    VStack {
                        if selectedAnswer == item.correctIndex {
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
                        }
                        Spacer()
                    }
                    .padding(.top, Constant.radius)
                    .padding(.horizontal, Constant.radius)
                    .foregroundColor(selectedAnswer == item.correctIndex ? Constant.purple : Color.red)
                    .background((selectedAnswer == item.correctIndex ? Constant.purple : Color.red).opacity(0.4))
                    .cornerRadius(24)
                }
                
                Button(action: {
                    if showAnswer {
                        if selectedAnswer == item.correctIndex {
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
                        ? (selectedAnswer == item.correctIndex ? Constant.purple : Color.red)
                        : (selectedAnswer != nil ? Constant.purple : Constant.gray)
                )
                .cornerRadius(Constant.radius / 2)
                .padding(.bottom, Constant.radius)
                .padding(.horizontal, Constant.radius)
                .padding(.top, Constant.width * 0.2)
            }
            .frame(maxWidth: .infinity, maxHeight: Constant.width * 0.4)
        }
    }
}
