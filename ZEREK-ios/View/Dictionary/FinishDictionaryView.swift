//
//  FinishDictionaryView.swift
//  ZEREK
//
//  Created by  Admin on 07.05.2025.
//

import SwiftUI

struct FinishDictionaryView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            Image("congradulations")
                .resizable()
                .frame(width: 250, height: 350)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Constant.getText(text: "Continue", font: .bold, size: 24)
                    .padding(Constant.radius)
                    .frame(maxWidth: .infinity)
                    .background(Constant.gold)
                    .foregroundColor(.white)
            }
            .cornerRadius(Constant.radius)
            .padding(.horizontal, 16)
        }
    }
}
