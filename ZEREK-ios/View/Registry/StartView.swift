//
//  StartView.swift
//  ZEREK-ios
//
//  Created by bakebrlk on 07.03.2025.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject private var viewModel: RegistryViewModel
    @EnvironmentObject private var navigation: Navigation

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 1)
                .frame(maxWidth: .infinity, maxHeight: 64)
                .foregroundColor(Color(red: 125/255, green: 128/255, blue: 218/255))
                .ignoresSafeArea()
            Spacer()
            
            Image("6")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 170)
            
            VStack {
                Text("Hello \(viewModel.info.firstName)! ✋")
                Text("Welcome to Zerek")
            }
            .font(.system(size: 24, weight: .medium))
            .padding()
            
            Button(action: {
                navigation.setTabBarAsRoot()
            }, label: {
                Text("Start")
                    .padding()
                    .frame(maxWidth: UIScreen.main.bounds.width/2.5)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                    .background(Color(red: 91/255, green: 123/255, blue: 254/255))
                    .cornerRadius(12)
                    .padding()
                    .padding(.top)
            })
            
            Spacer()
        }
    }
}

#Preview {
    StartView()
}
