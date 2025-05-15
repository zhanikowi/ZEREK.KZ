//
//  LevelModle.swift
//  ZEREK
//
//  Created by bakebrlk on 28.03.2025.
//

import SwiftUI

struct LevelModel: Identifiable {
    let id: UUID = UUID()
    let image: String
    var words: [LevelTest]
    let sentence: String
    let answer: String
    let fillText: String
}

struct LevelTest: Identifiable {
    let id: UUID = UUID()
    let words: String
}
