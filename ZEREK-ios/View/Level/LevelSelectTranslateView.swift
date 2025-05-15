//
//  LevelSelectTranslateView.swift
//  ZEREK
//
//  Created by bakebrlk on 02.04.2025.
//

import SwiftUI

struct LevelSelectTranslateView: View {
    var onContinue: () -> Void
        
    @State private var selectedAnswer: Int?
    let answer: String = "milk"
    let question: String = "What means “cут”?"
    let options: [String] = ["coffee", "meal", "milk"]
    @State private var showAnswer: Bool = false
    
    private var qazaqWord: some View {
        Constant.getText(text: "cут", font: .regular, size: Constant.radius)
            .padding(.vertical, Constant.radius/2)
            .padding(.horizontal, Constant.radius)
    }
    
    private var title: some View {
        Constant.getText(text: "Read and choose the correct translation", font: .bold, size: 24)
            .padding(.top, Constant.radius)
            .padding(.horizontal, Constant.radius)
    }
    
    private var questionView: some View {
        Constant.getText(text: question, font: .bold, size: Constant.radius)
            .padding(.bottom, Constant.radius)
            .padding(.horizontal, Constant.radius)
    }
    
    private func radioButton(index: Int) -> some View{
        Button(action: {
            selectedAnswer = index
        }) {
            HStack {
                Text(options[index])
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background( selectedAnswer == index ? Constant.gold.opacity(0.4) : Color.clear)
            .overlay {
                RoundedRectangle(cornerRadius: Constant.radius/2)
                    .stroke(selectedAnswer == index ? Constant.black : Constant.gray.opacity(0.3), lineWidth: 1)
            }
            .cornerRadius(Constant.radius/2)
        }
        .padding(.horizontal, Constant.radius)
    }
    
    private var continueButton: some View {
        Button(action: {
            if showAnswer {
                onContinue()
            } else {
                showAnswer.toggle()
            }
        }) {
            Text("Continue")
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
        }
        .background(
             showAnswer  ?
                (answer == options[selectedAnswer!] ? Constant.purple : Color.red)
             :
                (selectedAnswer != nil) ? Constant.purple :  Constant.gray
        )
        .cornerRadius(Constant.radius/2)
        .padding(.bottom, Constant.radius)
        .padding(.horizontal, Constant.radius)
        
    }
    
    private var answerView: some View {
        VStack {
            if answer == options[selectedAnswer ?? 0] {
                HStack {
                    Image(systemName: "checkmark.circle.fill").configure
                        .frame(width: Constant.width * 0.085, height: Constant.width * 0.085)
                    
                    Constant.getText(text: "Good job!", font: .bold, size: 24)
                    Spacer()
                }
            }else {
                HStack {
                    Constant.getText(text: "Right answer:", font: .bold, size: 24)
                    Constant.getText(text: answer, font: .regular, size: 24)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            Spacer()
        }
        .padding(.top, Constant.radius)
        .padding(.horizontal, Constant.radius)
        .foregroundColor(answer == options[selectedAnswer ?? 0] ? Constant.purple : Color.red)
        .background(answer == options[selectedAnswer ?? 0] ? Constant.purple.opacity(0.4) : Color.red.opacity(0.4))
    }
    
    private func didTapClose() {
        
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constant.radius) {
            
            title
            qazaqWord
            
            questionView
            
            ForEach(0..<options.count, id: \.self) { index in
                radioButton(index: index)
            }
            
            Spacer()
            ZStack {
                if showAnswer {
                    answerView
                }
                continueButton
                    .padding(.top, Constant.width * 0.2)
            }
            .frame(maxWidth: .infinity, maxHeight: Constant.width * 0.4)
        }
    }
}
