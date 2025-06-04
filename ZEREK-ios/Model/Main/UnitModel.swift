//
//  UnitModel.swift
//  ZEREK
//
//  Created by bakebrlk on 28.03.2025.
//

import SwiftUI
import FirebaseFirestore

enum UnitDocumentType: String, CaseIterable {
    case fillText
    case finishSentence
    case makeSentence
    case correctTranslations
}

struct FillTextItem {
    let question: String
    let correct: String
}

struct FinishSentenceItem {
    let question: String
    let options: [String]
    let correctIndex: Int
}

struct CorrectTranslationsItem {
    let question: String
    let options: [String]
    let correctIndex: Int
}

struct MakeSentenceItem {
    let question: String
    let shuffledWords: [String]
    let correctSentence: String
}

struct UnitContent: Identifiable {
    let id: UUID = UUID()
    let unitIcon: String
    var fillText: [FillTextItem] = []
    var finishSentence: [FinishSentenceItem] = []
    var correctTranslations: [CorrectTranslationsItem] = []
    var makeSentence: [MakeSentenceItem] = []
}

struct UnitsModel: Identifiable {
    let id: UUID = UUID()
    let iconName: String
    let title: String
    let description: String
    let queue: Int
    let units: [Units]
}

struct Units: Identifiable {
    let id: UUID = UUID()
    var fillText: [FillTextItem]
    var finishSentence: [FinishSentenceItem]
    var correctTranslations: [CorrectTranslationsItem]
    var makeSentence: [MakeSentenceItem]

    var allLevels: [Levels] {
        var result: [Levels] = []

        result.append(contentsOf: fillText.map { Levels.fromFillText($0) })
        result.append(contentsOf: finishSentence.map { Levels.fromFinishSentence($0) })
        result.append(contentsOf: correctTranslations.map { Levels.fromCorrectTranslations($0) })
        result.append(contentsOf: makeSentence.map { Levels.fromMakeSentence($0) })

        return result
    }
}

struct Levels: Identifiable {
    typealias Payload = Any
    
    let id = UUID()
    let type: UnitDocumentType
    let title: String
    let subtitle: String?
    let payload: Payload
}

extension Levels {
    static func fromFillText(_ item: FillTextItem) -> Levels {
        Levels(
            type: .fillText,
            title: item.question,
            subtitle: nil,
            payload: item
        )
    }

    static func fromFinishSentence(_ item: FinishSentenceItem) -> Levels {
        Levels(
            type: .finishSentence,
            title: item.question,
            subtitle: item.options.joined(separator: " • "),
            payload: item
        )
    }

    static func fromCorrectTranslations(_ item: CorrectTranslationsItem) -> Levels {
        Levels(
            type: .correctTranslations,
            title: item.question,
            subtitle: item.options.joined(separator: " / "),
            payload: item
        )
    }

    static func fromMakeSentence(_ item: MakeSentenceItem) -> Levels {
        Levels(
            type: .makeSentence,
            title: item.question,
            subtitle: item.shuffledWords.joined(separator: " "),
            payload: item
        )
    }
}


// MARK: DEPRECATED

struct UnitModel: Identifiable {
    let id: UUID = UUID()
    let title: Int
    let description: String
    let levels: [LevelModel]
    let imageName: String
}

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
