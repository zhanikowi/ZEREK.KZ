//
//  LevelPutWordView.swift
//  ZEREK
//
//  Created by bakebrlk on 04.04.2025.
//

import SwiftUI

struct LevelPutWordView: View {
    var onContinue: () -> Void
    
    @ObservedObject private var vm: MainViewModel = MainViewModel()
    @State private var showAnswer: Bool = false
    
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
        ZStack {
            Constant.getText(text: vm.selectLevel?.sentence ?? "Loading...", font: .regular, size: 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(Constant.radius)
            if vm.selectedWord != "" {
                Constant.getText(text: vm.selectedWord, font: .regular, size: 20)
                    .padding(Constant.radius / 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: Constant.radius)
                            .stroke(Constant.gray, lineWidth: 1)
                    )
                    .padding(.bottom, Constant.radius * 1.5)
            }
        }
    }
    
    private func didTapClose() {
        
    }
    
    private var words: some View {
        let numberOfRows: CGFloat = 4
        
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        return  LazyVGrid(columns: columns) {
            ForEach(vm.units[0].levels[0].words) { word in
                Button {
                    withAnimation {
                        if vm.selectedWord == word.words {
                            vm.selectedWord = ""
                        }else {
                            vm.selectedWord = word.words
                        }
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
            image
            
            textsView
            words
            
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
