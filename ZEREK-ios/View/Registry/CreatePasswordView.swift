//
//  CreatePasswordView.swift
//  ZEREK-ios
//
//  Created by bakebrlk on 07.03.2025.
//

import SwiftUI

struct CreatePasswordView: View {
    @EnvironmentObject private var viewModel: RegistryViewModel
    @EnvironmentObject var navigation: Navigation

    private var navigationBar: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 1)
                .foregroundColor(Color(red: 125/255, green: 128/255, blue: 218/255))
                .ignoresSafeArea()
            
            HStack {
                Button(action:{
                    navigation.navigateBack()
                }, label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 20, maxHeight: 20)
                })
                .padding(.leading)
                
                Spacer()
                
                Text("Signup")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 17, weight: .medium))
                    .padding(.trailing, 40)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 0.0796)
        .foregroundColor(.white)
    }
    
    private var title: some View {
        VStack {
            Text("Create an Account")
                .font(.system(size: 22, weight: .medium))
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    private var password: some View {
        VStack {
            Text("Password")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 15))
            
            HStack {
                if viewModel.isSecure {
                    SecureField("Your password", text: $viewModel.info.password)
                        .autocorrectionDisabled()
                }else {
                    TextField("Your password", text: $viewModel.info.password)
                        .autocorrectionDisabled()
                }
                Button(action: {
                    viewModel.isSecure.toggle()
                }, label: {
                    Image(systemName: !viewModel.isSecure ? "eye" : "eye.slash")
                        .foregroundColor(Color(.systemGray3))
                })
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(16)
        }
        .padding()
    }
    
    private var confirmPassword: some View {
        VStack {
            Text("Confirm Password")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 15))
            
            HStack {
                if viewModel.isSecure {
                    SecureField("Confirm Password", text: $viewModel.confirmPassword)
                        .autocorrectionDisabled()
                }else {
                    TextField("Confirm Password", text: $viewModel.confirmPassword)
                        .autocorrectionDisabled()
                }
                Button(action: {
                    viewModel.isSecure.toggle()
                }, label: {
                    Image(systemName: !viewModel.isSecure ? "eye" : "eye.slash")
                        .foregroundColor(Color(.systemGray3))
                })
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(16)
        }
        .padding(.horizontal)
    }
    
    private var signUpButton: some View {
        Button(action: {
            Task {
                if await viewModel.didTapSignUp() {
                    navigation.navigate(to: .start)
                }
            }
        }, label: {
            Text("Signup")
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Color(red: 91/255, green: 123/255, blue: 254/255))
                .font(.system(size: 20, weight: .medium))
                .cornerRadius(16)
                .padding(.horizontal)
        })
        .padding(.top, 40)
    }
    
    private var loginButton: some View {
        Button(action: {
            navigation.navigate(to: .signIn)
        }, label: {
            Group {
                Text("Already you member? ")
                    .foregroundColor(Color(.systemGray))
                + Text("Login")
                    .foregroundColor(Color(red: 91/255, green: 123/255, blue: 254/255))
                    .fontWeight(.medium)
            }
            .font(.system(size: 17))
        })
        .padding(.top)
    }
    
    var body: some View {
        VStack {
            navigationBar
            title
            
            password
            confirmPassword
            
            Spacer()
            signUpButton
            loginButton
            
            Spacer()
        }
    }
}


#Preview {
    CreatePasswordView()
}
