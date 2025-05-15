//
//  LevelSelectAllSecntenceView.swift
//  ZEREK
//
//  Created by bakebrlk on 09.04.2025.
//

import SwiftUI

struct LevelSelectAllSentenceView: View {
    var onContinue: () -> Void
    
    @ObservedObject private var vm: MainViewModel = MainViewModel()
    @State private var showAnswer: Bool = false
    @State private var answer: [LevelTest] = []
    
    private var title: some View {
        Constant.getText(text: "Translate and make the sentence", font: .bold, size: 24)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, Constant.radius*2)
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
            Constant.getText(text: vm.selectLevel?.sentence ?? "Loading...", font: .regular, size: 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(Constant.radius)
        }
    }
    
    private func didTapClose() {
        
    }
    
    private var answerWords: some View {
        
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        return ZStack {
            VStack {
                Divider()
                    .padding(.top, Constant.radius * 2)
                Divider()
                    .padding(.top, Constant.radius * 2)
            }
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(answer) { word in
                    Button(action: {
                        withAnimation(.easeInOut) {
                            vm.selectLevel?.words.append(word)
                            answer.removeAll { $0.words == word.words }
                        }
                    }) {
                        Text(word.words)
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
            .frame(maxWidth: .infinity, alignment: .leading) // Слова не растягиваются
            .padding(.horizontal, 16)
        }
        
    }
    
    private var words: some View {
        let numberOfRows: CGFloat = 4
        
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        return LazyVGrid(columns: columns) {
                ForEach(vm.selectLevel!.words) { word in
                    Button {
                        withAnimation {
                            vm.selectLevel?.words.removeAll(where: {$0.id == word.id})
                            answer.append(word)
                        }
                    } label: {
                        Text(word.words)
                            .frame(maxWidth: Constant.width/numberOfRows)
                            .padding(.horizontal, Constant.radius/4)
                            .padding(.vertical, Constant.radius * 0.2)
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
             (vm.selectLevel?.answer == vm.selectedWord ? Constant.purple : Color.red)
             :
                (vm.selectedWord != "") ? Constant.purple :  Constant.gray
        )
        .cornerRadius(Constant.radius/2)
        .padding(.bottom, Constant.radius)
        .padding(.horizontal, Constant.radius)
        
    }
    
    private var answerView: some View {
        VStack {
            if vm.selectLevel?.answer == vm.selectedWord {
                HStack {
                    Image(systemName: "checkmark.circle.fill").configure
                        .frame(width: Constant.width * 0.085, height: Constant.width * 0.085)
                    
                    Constant.getText(text: "Good job!", font: .bold, size: 24)
                    Spacer()
                }
            }else {
                HStack {
                    Constant.getText(text: "Right answer:", font: .bold, size: 24)
                    Constant.getText(text: vm.selectLevel!.answer, font: .regular, size: 24)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            Spacer()
        }
        .padding(.top, Constant.radius)
        .padding(.horizontal, Constant.radius)
        .foregroundColor(vm.selectLevel!.answer == vm.selectedWord ? Constant.purple : Color.red)
        .background(vm.selectLevel!.answer == vm.selectedWord ? Constant.purple.opacity(0.4) : Color.red.opacity(0.4))
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
                }
                VStack {
                    Spacer()
                    continueButton
                }
            }
            .frame(maxWidth: .infinity, maxHeight: Constant.width * 0.4)
        }
    }
}
