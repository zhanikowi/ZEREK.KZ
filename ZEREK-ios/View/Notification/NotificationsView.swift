//
//  NotificationsView.swift
//  ZEREK
//
//  Created by bakebrlk on 23.04.2025.
//

import SwiftUI

struct NotificationsView: View {
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
            Constant.getText(text: "Notification", font: .bold, size: 22)
                .frame(maxWidth: .infinity)
                .padding(.trailing, Constant.radius)
        }
        .foregroundColor(.primary)
        .padding(.horizontal, Constant.radius)
    }
    
    private func notificationConfigure(title: String,
                                       description: String,
                                       date: Date,
                                       isReaded: Bool? = nil) -> some View {
        HStack {
            VStack {
                Constant.getText(text: title, font: .regular, size: 18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Constant.getText(text: description, font: .regular, size: 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color.gray)
            }
            
            VStack(alignment: .trailing) {
                HStack {
                    Constant.getText(text: date.toString, font: .regular, size: 12)
                    Image(systemName: "chevron.right")
                }
                
                if isReaded != nil {
                    Constant.getText(text: "1",
                                     font: .regular,
                                     size: 15)
                    .frame(maxWidth: Constant.radius, maxHeight: Constant.radius)
                    .foregroundColor(.primary)
                    .background(Constant.gold)
                    .cornerRadius(Constant.radius/2)
                }else {
                    Spacer()
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(Constant.radius/2)
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 10.3)
        .background(Color(.systemGray6))
        .cornerRadius(Constant.radius/2)
        .padding(.horizontal, Constant.radius)
        .onTapGesture {
            navigation.navigate(to: .notificationMessages)
        }
    }
    
    var body: some View {
        VStack {
            topBar
            
            notificationConfigure(title: "Learning & Progress", description: "Daily Reminder", date: Date(), isReaded: false)
                .padding(.top, Constant.radius)
            
            notificationConfigure(title: "Account notifications", description: "Password Change Confirmation", date: Date())
            Spacer()
        }
    }
}

#Preview {
    NotificationsView()
}
