//
//  RegistryPurposeView.swift
//  ZEREK-ios
//
//  Created by bakebrlk on 07.03.2025.
//

import SwiftUI

struct RegistryPurposeView: View {
    @EnvironmentObject private var viewModel: RegistryViewModel
    @EnvironmentObject var navigation: Navigation

    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 1)
                .frame(maxWidth: .infinity, maxHeight: 64)
                .foregroundColor(Color(red: 125/255, green: 128/255, blue: 218/255))
                .ignoresSafeArea()
            Spacer()
            
            Text("What is your Purpose to learn Kazakh?")
                .font(.system(size: 24, weight: .medium))
                .padding(.bottom)
            
            getPurpose("Travel", image: "travel")
            getPurpose("Study", image: "study")
            getPurpose("Others", image: nil)
            
            Button(action: {
                navigation.navigate(to: .createAccount)
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
                Image("4")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.77)
                    .padding(.leading, UIScreen.main.bounds.width * 0.77/1.6)
            }
        }
    }
    
    private func getPurpose(_ text: String, image: String?) -> some View {
        Button(action: {
            viewModel.info.purpose = text
        }, label: {
            HStack {
                if image != nil {
                    Image(image!)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 31, maxHeight: 31)
                }
                
                Text(text)
                    .foregroundColor(viewModel.info.purpose == text ? .white : .black)
                    .font(.system(size: 24, weight: .medium))
                    
            }
            .padding(.vertical, 5)
            .padding(.horizontal)
            .frame(maxWidth: UIScreen.main.bounds.width * 0.35)
            .background(viewModel.info.purpose == text ? Color(red: 120/255, green: 111/255, blue: 1).opacity(0.7) : .clear)
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
    RegistryPurposeView()
}
