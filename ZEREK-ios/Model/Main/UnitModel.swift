//
//  UnitModel.swift
//  ZEREK
//
//  Created by bakebrlk on 28.03.2025.
//

import SwiftUI
import FirebaseFirestore

struct UnitModel: Identifiable {
    let id: UUID = UUID()
    let title: Int
    let description: String
    let levels: [LevelModel]
    let imageName: String
}

struct UnitTest: Identifiable, Codable {
    var id = UUID()
    var title: String
    var questions: [String]
}
