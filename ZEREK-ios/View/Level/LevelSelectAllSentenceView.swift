//
//  LevelSelectAllSentenceView.swift
//  ZEREK
//
//  Created by bakebrlk on 09.04.2025.
//

import SwiftUI

struct LevelSelectAllSentenceView: View {
    let item: MakeSentenceItem
    var onContinue: () -> Void
    var onWrong: () -> Void
    
    @State private var showAnswer: Bool = false
    @State private var answer: [String] = []
    @State private var availableWords: [String] = []
    
    private var title: some View {
        Constant.getText(text: "Translate and make the sentence", font: .bold, size: 24)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, Constant.radius * 2)
            .padding(.horizontal, Constant.radius)
    }
    
    private var image: some View {
        Image("koiJuu").configure
            .frame(maxWidth: Constant.width * 0.57)
            .padding(Constant.radius)
            .padding(.top, Constant.radius)
    }
    
    private var textsView: some View {
        ZStack {
            Constant.getText(text: item.question, font: .regular, size: 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(Constant.radius)
        }
    }
    
    private var answerWords: some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        return ZStack {
            VStack {
                if item.shuffledWords.count > 3 {
                    Divider().padding(.top, Constant.radius * 2)
                }
                Divider().padding(.top, Constant.radius * 2)
            }
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(answer, id: \.self) { word in
                    Button(action: {
                        withAnimation(.easeInOut) {
                            availableWords.append(word)
                            answer.removeAll { $0 == word }
                        }
                    }) {
                        Text(word)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            )
                            .foregroundColor(.black)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
        }
    }
    
    private var words: some View {
        let numberOfRows: CGFloat = 3
        let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        
        return LazyVGrid(columns: columns) {
            ForEach(availableWords, id: \.self) { word in
                Button {
                    withAnimation {
                        availableWords.removeAll(where: { $0 == word })
                        answer.append(word)
                    }
                } label: {
                    Text(word)
                        .frame(maxWidth: Constant.width/numberOfRows)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: Constant.radius/1.5)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                        .foregroundColor(.black)
                        .padding(.top, Constant.radius * 0.5)
                }
            }
        }
        .padding(.horizontal, Constant.radius)
        .padding(.top, Constant.radius * 2)
    }
    
    private var continueButton: some View {
        let userAnswer = answer.joined(separator: " ")
        
        return Button(action: {
            if showAnswer {
                if userAnswer == item.correctSentence {
                    onContinue()
                } else {
                    onWrong()
                }
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
            showAnswer ?
                (userAnswer == item.correctSentence ? Constant.purple : Color.red)
                :
                (!answer.isEmpty ? Constant.purple : Constant.gray)
        )
        .cornerRadius(Constant.radius / 2)
        .padding(.bottom, Constant.radius)
        .padding(.horizontal, Constant.radius)
    }
    
    private var answerView: some View {
        let userAnswer = answer.joined(separator: " ")
        let isCorrect = userAnswer == item.correctSentence
        
        return VStack {
            if isCorrect {
                HStack {
                    Image(systemName: "checkmark.circle.fill").configure
                        .frame(width: Constant.width * 0.085, height: Constant.width * 0.085)
                    Constant.getText(text: "Good job!", font: .bold, size: 24)
                    Spacer()
                }
            } else {
                HStack {
                    Constant.getText(text: "Right answer:", font: .bold, size: 24)
                    Constant.getText(text: item.correctSentence, font: .regular, size: 20)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            Spacer()
        }
        .padding(.top, Constant.radius)
        .padding(.horizontal, Constant.radius)
        .foregroundColor(isCorrect ? Constant.purple : Color.red)
        .background(isCorrect ? Constant.purple.opacity(0.4) : Color.red.opacity(0.4))
    }
    
    var body: some View {
        VStack {
            title
            textsView
            image
            answerWords
            words
            
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
        .onAppear {
            availableWords = item.shuffledWords
        }
    }
}


#Preview {
    LevelSelectAllSentenceView(
        item: MakeSentenceItem(
            question: "Translate and make the sentence: Banu lives in Almaty",
            shuffledWords: ["Алматыда", "Бану", "тұрады"],
            correctSentence: "Бану Алматыда тұрады"
        ),
        onContinue: {
            print("✅ Correct answer, continue tapped.")
        },
        onWrong: {
            print("❌ Wrong answer, continue tapped.")
        }
    )
}

