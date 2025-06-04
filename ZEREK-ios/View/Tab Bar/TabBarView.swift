//
//  TabBarView.swift
//  ZEREK
//
//  Created by bakebrlk on 18.04.2025.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject private var vm: MainViewModel
    
    private func item(imageName: String, page: Page) -> some View {
        Button {
            vm.page = page
        } label: {
            Image(systemName: imageName)
                .configure
                .frame(maxWidth: Constant.radius * 1.3, maxHeight: Constant.radius * 1.3)
                .foregroundColor(vm.page == page ? Constant.gold : Constant.purple)
        }

    }
    
    var body: some View {
        VStack {
            
            switch vm.page {
            case .home:
                MainView()
            case .book:
                AudioDictionaryView()
            case .video:
                VideoCallView()
            case .rank:
                RatingView()
            case .profile:
                ProfileView()
            }
            
            Spacer()
            
            Divider()
                .padding(.bottom, Constant.radius * 0.3)
            HStack (spacing: Constant.radius * 1.7){
                item(imageName: "house.fill", page: .home)
                item(imageName: "book.pages", page: .book)
                item(imageName: "video", page: .video)
                item(imageName: "trophy", page: .rank)
                item(imageName: "person", page: .profile)
            }
        }
    }
}

#Preview {
    TabBarView()
}

enum Page {
    case home
    case book
    case video
    case rank
    case profile
}
