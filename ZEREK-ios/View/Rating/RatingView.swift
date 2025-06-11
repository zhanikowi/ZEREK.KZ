//
//  RatingView.swift
//  ZEREK
//
//  Created by bakebrlk on 02.04.2025.
//

import SwiftUI

struct RatingView: View {
    @EnvironmentObject private var vm: MainViewModel
    @StateObject private var ratingViewModel = RatingViewModel()

    private func userView(user: UserRatingModel) -> some View {
        HStack {
            Constant.getText(
                text: user.rank <= 3 ? ["🥇", "🥈", "🥉"][user.rank - 1] : "\(user.rank).",
                font: .bold,
                size: 20
            )
            .frame(maxWidth: Constant.width * 0.08,
                   maxHeight: Constant.width * 0.08)

            Image(user.photo)
                .configure
                .padding(Constant.radius / 2)
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
        Image("6")
            .configure
            .frame(maxWidth: Constant.width * 0.27)
    }

    private var rankText: some View {
        Constant.getText(
            text: "Rating",
            font: .bold,
            size: 24
        )
    }

    var body: some View {
        VStack {
            image
            rankText

            if ratingViewModel.isLoading {
                Spacer()
                ProgressView("Loading rating...")
                    .progressViewStyle(CircularProgressViewStyle(tint: Constant.purple))
                    .scaleEffect(1.3)
                    .padding()
                Spacer()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: Constant.radius / 2) {
                        ForEach(ratingViewModel.userRatings) { user in
                            userView(user: user)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: Constant.radius / 2)
                            .fill(Color(.systemGray6))
                    )
                    .padding()
                }
            }

            Spacer()
        }
    }
}
