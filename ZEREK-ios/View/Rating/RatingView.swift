//
//  RatingView.swift
//  ZEREK
//
//  Created by bakebrlk on 02.04.2025.
//
import SwiftUI

struct RatingView: View {
    @ObservedObject private var vm: MainViewModel = MainViewModel()
    
    private func userView(user: UserRatingModel) -> some View {
        HStack {
            Constant.getText(text: user.rank <= 3 ? ["🥇", "🥈", "🥉"][user.rank - 1] : "\(user.rank).", font: .bold, size: 20)
                .frame(maxWidth: Constant.width * 0.08,
                       maxHeight: Constant.width * 0.08)
                
            Image(user.photo).configure
                .padding(Constant.radius/2)
                .background(Constant.purple)
                .frame(maxWidth: Constant.width * 0.12)
                .cornerRadius(Constant.width * 0.06)
            
            Constant.getText(text: user.name, font: .bold, size: 20)
            
            Spacer()
            
            Constant.getText(text: "\(user.score) points", font: .regular, size: 20)
        }
        .padding(.top)
    }
    
    private var image: some View {
        Image("6").configure
            .frame(maxWidth: Constant.width * 0.27)
    }
    
    private var rankText: some View {
        Constant.getText(text: "You ranked \(vm.user.rank) last week", font: .bold, size: 24)
    }
    var body: some View {
        VStack {
            image
            rankText
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: Constant.radius/2) {
                    ForEach(vm.users) { user in
                        userView(user: user)
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: Constant.radius/2).fill(Color(.systemGray6)))
                .padding()
            }
            Spacer()
        }
    }
}

#Preview {
    RatingView()
}
