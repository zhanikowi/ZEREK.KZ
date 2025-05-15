//
//  LevelFillView.swift
//  ZEREK
//
//  Created by bakebrlk on 09.04.2025.
//

import SwiftUI

struct LevelFillView: View {
    var onContinue: () -> Void
    
    @ObservedObject private var vm: MainViewModel = MainViewModel()
    @State private var showAnswer: Bool = false
    @State private var answer: String = ""
    
    private var title: some View {
        Constant.getText(text: "Fill in the text", font: .bold, size: 24)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, Constant.radius*2)
            .padding(.horizontal, Constant.radius)
    }
    
    private var image: some View {
        Image("koiJuu").configure
            .frame(maxWidth: Constant.width * 0.57, maxHeight: Constant.width * 0.57)
            .padding(Constant.radius)
            .padding(.top, Constant.radius)
    }
    
    private func didTapClose() {
        
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
    
    private var fillText: some View {
        HStack {
            Constant.getText(text: vm.selectLevel!.fillText, font: .regular, size: 20)
            TextField("_________", text: $answer)
            Constant.getText(text: ".", font: .regular, size: 20)

        }
        .padding(.horizontal, Constant.radius)
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
