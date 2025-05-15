//
//  NotificationView.swift
//  ZEREK
//
//  Created by bakebrlk on 23.04.2025.
//

import SwiftUI

struct NotificationView: View {
    @EnvironmentObject var navigation: Navigation
    
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
            Constant.getText(text: "Zerek", font: .bold, size: 22)
                .frame(maxWidth: .infinity)
                .padding(.trailing, Constant.radius)
        }
        .foregroundColor(.primary)
        .padding(.horizontal, Constant.radius)
    }
    
    private func messageConfigure(date: Date, title: String, description: String) -> some View {
        VStack {
            Constant.getText(text: date.toString1, font: .regular, size: 10)
                .background(Color(.systemGray6))
                .cornerRadius(Constant.radius/3)
                .padding(Constant.radius)
            
            VStack {
                HStack {
                    Constant.getText(text: title, font: .regular, size: 15)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Constant.purple)
                    
                    Spacer()
                    Constant.getText(text: date.toString2, font: .regular, size: 10)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                Constant.getText(text: description, font: .regular, size: 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color.primary)
            }
            .padding(Constant.radius/2)
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray6))
            .padding(.horizontal, Constant.radius)
            .cornerRadius(Constant.radius/2)
        }
    }
    
    private var messages: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                messageConfigure(date: Date(),
                                 title: "Milestone achievement 🏆",
                                 description: "Congratulations! You've completed 10 lessons in Kazakh!")
                messageConfigure(date: Date(),
                                 title: "Daily reminder 🎗️",
                                 description: "Don't forget to practice today! Keep your streak going!")
            }
        }
    }
    var body: some View {
        VStack {
            topBar
            messages
        }
    }
}

#Preview {
    NotificationView()
}
