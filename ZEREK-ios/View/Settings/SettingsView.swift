//
//  SettingsView.swift
//  ZEREK
//
//  Created by bakebrlk on 23.04.2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var navigation: Navigation
    @EnvironmentObject var vm: MainViewModel
    
    private var backgroundRectangle: some View {
        VStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 3.7)
                .foregroundColor(Constant.purple)
                .cornerRadius(Constant.radius * 2)
            Spacer()
        }
    }
    
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
            Constant.getText(text: "Settings", font: .bold, size: 22)
                .frame(maxWidth: .infinity)
                .padding(.trailing, Constant.radius)
        }
        .foregroundColor(.white)
        .padding(.horizontal, Constant.radius)
        .padding(.top, Constant.radius * 3)
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
        .padding(.top, Constant.radius * 2)
    }
    
    private func itemConfigure(systemImageName: String,
                               title: String,
                               count: Int? = nil,
                               isButton: Bool? = nil,
                               action: @escaping () -> Void
    ) -> some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName: systemImageName)
                    .configure
                    .frame(maxWidth: Constant.radius * 1.5,
                           maxHeight: Constant.radius * 1.5)
                    .foregroundColor(Constant.purple)
                
                Constant.getText(text: title,
                                 font: .regular,
                                 size: 18)
                .padding(.horizontal, Constant.radius)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                if let integerCount: Int = count {
                    Constant.getText(text: "\(integerCount)",
                                     font: .regular,
                                     size: 15)
                    .frame(maxWidth: Constant.radius, maxHeight: Constant.radius)
                    .foregroundColor(.primary)
                    .background(Constant.gold)
                    .cornerRadius(Constant.radius/2)
                }
                
                if isButton != nil {
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.black)
                }
            }
        }
        .padding(.horizontal, Constant.radius)
        .padding(.top, Constant.radius * 0.5)
    }
    
    private var items: some View {
        VStack {
            itemConfigure(systemImageName: "qrcode", title: "Account information", isButton: true) {
                navigation.navigate(to: .editAccount)
            }
            itemConfigure(systemImageName: "bell.badge", title: "Notifications",count: 1 ,isButton: true){
                navigation.navigate(to: .notification)
            }
            
            itemConfigure(systemImageName: "exclamationmark.shield", title: "Privacy policy", isButton: true){
                navigation.navigate(to: .privacy)
            }
            itemConfigure(systemImageName: "trash", title: "Delete My Account", isButton: true){
                navigation.navigate(to: .deleteAccount)
            }
            
            itemConfigure(systemImageName: "rectangle.portrait.and.arrow.right", title: "Log out"){
                vm.signOut()
                navigation.navigate(to: .start)
            }
        }
        .padding(.top, Constant.radius * 3)
    }
    
    var body: some View {
        ZStack {
            backgroundRectangle
            VStack {
                topBar
                avatar
                
                items
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SettingsView()
}
