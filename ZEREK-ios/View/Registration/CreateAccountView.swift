//
//  CreateAccountView.swift
//  ZEREK-ios
//
//  Created by bakebrlk on 07.03.2025.
//

import SwiftUI

struct CreateAccountView: View {
    @EnvironmentObject private var viewModel: RegistrationViewModel
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
    
    private var firstName: some View {
        VStack {
            Text("First Name")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 15))
            
            TextField("First Name", text: $viewModel.info.firstName)
                .autocorrectionDisabled()
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
        }
        .padding()
    }
    
    private var lastName: some View {
        VStack {
            Text("Last Name")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 15))
            
            TextField("Last Name", text: $viewModel.info.lastName)
                .autocorrectionDisabled()
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
        }
        .padding(.horizontal)
    }
    
    private var email: some View {
        VStack {
            Text("Email Address")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 15))
            
            TextField("Your email", text: $viewModel.info.email)
                .autocorrectionDisabled()
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .textInputAutocapitalization(.never)
        }
        .padding()
    }
    
    private var continueButton: some View {
        Button(action: {
            navigation.navigate(to: .createPassword)
        }, label: {
            Text("Continue")
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
            
            firstName
            lastName
            
            email
            continueButton
            
            loginButton
            Spacer()
        }
    }
}

#Preview {
    CreateAccountView()
}
