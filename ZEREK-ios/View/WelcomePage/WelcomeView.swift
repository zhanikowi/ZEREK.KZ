//
//  WelcomeView.swift
//  ZEREK-ios
//
//  Created by bakebrlk on 07.03.2025.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var navigation: Navigation
    @EnvironmentObject private var viewModel: MainViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            Constant.getText(text: "Welcome to Zerek", font: .bold, size: 22)
                .padding(.bottom)
                        
            Image("1")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: UIScreen.main.bounds.width * 0.77)
            
            Button(action: {
                viewModel.showedOnboarding = true
                navigation.navigate(to: .selectAge)
            }, label: {
                Text("Continue")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color(red: 91/255, green: 123/255, blue: 254/255))
                    .cornerRadius(12)
                    .padding()
            })
            Spacer()
        }
    }
}

#Preview {
    WelcomeView()
}
