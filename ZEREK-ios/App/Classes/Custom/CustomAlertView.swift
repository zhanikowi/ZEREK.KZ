//
//  CustomAlertView.swift
//  ZEREK
//
//  Created by  Admin on 30.05.2025.
//

import SwiftUI

struct CustomAlertView: View {
    var title: String
    var message: String
    var buttonTitle: String
    var onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.primary)

            Text(message)
                .font(.system(size: 18))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            Button(action: onDismiss) {
                Text(buttonTitle)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Constant.purple)
                    .cornerRadius(12)
            }
        }
        .padding()
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Constant.purple, lineWidth: 2)
        )
        .cornerRadius(16)
        .padding(.horizontal, 40)
    }
}
