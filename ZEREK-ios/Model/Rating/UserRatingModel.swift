//
//  RatingModel.swift
//  ZEREK
//
//  Created by bakebrlk on 02.04.2025.
//

import Foundation

struct UserRatingModel: Identifiable {
    let id = UUID()
    let rank: Int
    let name: String
    let photo: String
    let score: Int
}
