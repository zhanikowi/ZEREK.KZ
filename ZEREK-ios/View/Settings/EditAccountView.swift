//
//  EditAccountView.swift
//  ZEREK
//
//  Created by bakebrlk on 23.04.2025.
//

import SwiftUI

struct EditAccountView: View {
    @EnvironmentObject private var viewModel: MainViewModel
    @EnvironmentObject private var navigation: Navigation
    @State private var editUser: UserModel = UserModel()
    @State private var password: String = ""
    @State private var confPassword: String = ""
    
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
            Constant.getText(text: "Account", font: .bold, size: 22)
                .frame(maxWidth: .infinity)
                .padding(.trailing, Constant.radius)
        }
        .foregroundColor(.primary)
        .padding(.horizontal, Constant.radius)
    }
    
    private var avatar: some View {
        ZStack {
            Image("Profile")
                .configure
                .padding([.horizontal, .top], Constant.radius * 0.8)
                .frame(maxWidth: Constant.width / 2.7,
                       maxHeight: Constant.width / 2.7)
                .background(Color(.systemGray4))
                .cornerRadius(Constant.width / 1.35)
            
            VStack (alignment: .trailing){
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: "square.and.pencil")
                        .configure
                        .frame(maxWidth: Constant.radius * 1.3,
                               maxHeight: Constant.radius * 1.3)
                        .padding(.trailing, Constant.radius * 0.7)
                }
            }
        }
        .frame(maxWidth: Constant.width / 2.6,
               maxHeight: Constant.width / 2.6)
        .padding(.top, Constant.radius)
    }
    
    private func textFieldConfigure(title: String, hint: String, text: Binding<String>) -> some View {
        HStack {
            Constant.getText(text: title, font: .regular, size: 15)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField(hint, text: text)
                .multilineTextAlignment(.trailing)
                .foregroundColor(.black)
            
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.6), lineWidth: 1)
        )
        .cornerRadius(8)
    }
    
      private func secureFieldConfigure(title: String, hint: String, text: Binding<String>) -> some View {
        HStack {
            Constant.getText(text: title, font: .regular, size: 15)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            SecureField(hint, text: text)
                .multilineTextAlignment(.trailing)
                .foregroundColor(.black)
            
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.6), lineWidth: 1)
        )
        .cornerRadius(8)
    }
    
    
    private var userInfo: some View {
        VStack {
            textFieldConfigure(title: "First Name:",
                               hint: viewModel.user.firstName,
                               text: $editUser.firstName)
            textFieldConfigure(title: "Last Name:", hint: viewModel.user.lastName, text: $editUser.lastName)
            
            secureFieldConfigure(title: "Password:", hint: "*******", text: $password)
            secureFieldConfigure(title: "Confirm password:", hint: "*******", text: $confPassword)
        }
    }
    
    private var saveButton: some View {
        Button {
            viewModel.updateUserData(name: editUser.firstName, surename: editUser.lastName, password: password)
            navigation.navigateBack()
        } label: {
            Constant.getText(text: "Save", font: .bold, size: 24)
                .padding(Constant.radius)
                .frame(maxWidth: .infinity)
                .background(Constant.gold)
                .foregroundColor(.white)
        }
        .cornerRadius(Constant.radius)
    }
    
    var body: some View {
        VStack {
            topBar
            Spacer()
            
            avatar
            Spacer()
            userInfo
            
            Spacer()
            saveButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, Constant.radius)
    }
}

#Preview {
    EditAccountView()
}
