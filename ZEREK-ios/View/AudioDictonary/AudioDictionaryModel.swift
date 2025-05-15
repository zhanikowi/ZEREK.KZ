//
//  AudioDictionaryModel.swift
//  ZEREK
//
//  Created by  Admin on 07.05.2025.
//

import SwiftUI

struct AudioDictionaryModel: Identifiable {
    let id = UUID()
    let word: String
    let translation: String
    let audioFileName: String
}
