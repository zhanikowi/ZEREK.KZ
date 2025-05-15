//
//  RespectView.swift
//  ZEREK
//
//  Created by bakebrlk on 09.04.2025.
//

import SwiftUI

struct RespectView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var vm: MainViewModel = MainViewModel()

    private var title: some View {
        Constant.getText(text: vm.respectText, font: .bold, size: 24)
            .frame(maxWidth: Constant.width * 0.5)
            .padding(.leading, Constant.radius * 6)
            .foregroundColor(Constant.gold)
    }
    
    private func image(_ name: String) -> some View {
        Image(name)
            .resizable()
            .scaledToFit()
    }
    
    private func didTapClose() {
        dismiss()
    }
    
    private var continueButton: some View {
        Button(action: {
            dismiss()
        }) {
            Text("Continue")
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
        }
        .background( Constant.purple)
        .cornerRadius(Constant.radius/2)
        .padding(.bottom, Constant.radius)
        .padding(.horizontal, Constant.radius)
        
    }
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Group {
                    image("messageBG")
                        .frame(maxWidth: Constant.width * 0.55)
                        .padding(.leading, Constant.radius * 5)
                    
                    title
                }
                    .padding(.bottom, Constant.width * 0.5)
                HStack {
                    image("respect")
                        .frame(maxWidth: Constant.width * 0.5, alignment: .leading)
                    Spacer()
                }
            }
            
            Spacer()
            continueButton
        }
    }
}

#Preview {
    RespectView()
}
