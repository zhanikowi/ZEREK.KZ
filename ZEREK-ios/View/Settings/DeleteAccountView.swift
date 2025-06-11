//
//  DeleteAccountView.swift
//  ZEREK
//
//  Created by bakebrlk on 23.04.2025.
//

import SwiftUI

struct DeleteAccountView: View {
    @EnvironmentObject private var viewModel: MainViewModel
    @EnvironmentObject private var navigation: Navigation
    @State private var password: String = ""
    
    private var topBar: some View {
        HStack {
            Button {
                navigation.navigateBack()
            } label: {
                Image(systemName: "chevron.left")
                    .configure
                    .frame(maxWidth: Constant.radius, maxHeight: Constant.radius)
            }
            
            Spacer()
            Constant.getText(text: "Delete account", font: .bold, size: 22)
                .frame(maxWidth: .infinity)
                .padding(.trailing, Constant.radius)
        }
        .foregroundColor(.primary)
        .padding(.horizontal, Constant.radius)
    }
    
    private var hint: some View {
        Constant.getText(text: "Are you sure you want to delete your account? This action is permanent, and all your learning progress, saved words, and achievements will be lost.", font: .regular, size: 15)
            .padding(Constant.radius)
            .padding(.top, Constant.radius)
    }
    
    private var textField: some View {
        SecureField("Enter your password", text: $password)
            .padding(Constant.radius)
            .autocorrectionDisabled()
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay {
                RoundedRectangle(cornerRadius: Constant.radius/2)
                    .stroke(Color.gray, lineWidth: 1)
            }
            .padding(Constant.radius)
    }
    
    private var deleteButton: some View {
        ZStack {
            Button {
                Task {
                    await viewModel.deleteAccount(password: password, navigation: navigation)
                }
            } label: {
                Constant.getText(text: "Delete", font: .bold, size: 24)
                    .padding(Constant.radius)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
            }
            .cornerRadius(Constant.radius)
            .padding(Constant.radius)
            .disabled(viewModel.isLoading)

            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.red.opacity(0.7))
                    .cornerRadius(Constant.radius)
                    .padding(Constant.radius)
            }
        }
    }

    
    var body: some View {
        VStack {
            topBar
            hint
            
            textField
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            deleteButton
            Spacer()
        }
    }

}

#Preview {
    DeleteAccountView()
}
