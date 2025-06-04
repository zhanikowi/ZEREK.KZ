//
//  RegistryLevelView.swift
//  ZEREK-ios
//
//  Created by bakebrlk on 07.03.2025.
//

import SwiftUI

struct RegistryLevelView: View {
    @EnvironmentObject private var viewModel: RegistrationViewModel
    @EnvironmentObject var navigation: Navigation

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 1)
                .frame(maxWidth: .infinity, maxHeight: 64)
                .foregroundColor(Color(red: 125/255, green: 128/255, blue: 218/255))
                .ignoresSafeArea()
            Spacer()
            
            Text("What is your level?")
                .font(.system(size: 24, weight: .medium))
                .padding(.bottom)
            
            getLevel("A1")
            getLevel("A2")
            getLevel("B1")
            getLevel("B2")
            
            Button(action: {
                navigation.navigate(to: .selectPurpose)
            }, label: {
                Text("Next")
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
            
            HStack {
                Spacer()
                Image("3")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.77)
                    .padding(.leading, UIScreen.main.bounds.width * 0.77/1.6)
            }
        }
    }
    
    private func getLevel(_ text: String) -> some View {
        Button(action: {
            viewModel.info.level = text
        }, label: {
            Text(text)
                .shadow(color: .black.opacity(0.7), radius: 5, x: 3, y: 3)
                .padding(.horizontal)
                .padding(.vertical, 5)
                .frame(maxWidth: UIScreen.main.bounds.width/3.5)
                .foregroundColor(viewModel.info.level == text ? .white : .black)
                .background(viewModel.info.level == text ? Color(red: 120/255, green: 111/255, blue: 1).opacity(0.7) : .clear)
                .cornerRadius(20)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(red: 120/255, green: 111/255, blue: 1),lineWidth: 3)
                }
                .padding(.top)
            
        })
    }
}

#Preview {
    RegistryLevelView()
}
