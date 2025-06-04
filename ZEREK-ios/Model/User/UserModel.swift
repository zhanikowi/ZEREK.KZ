//
//  UserModel.swift
//  ZEREK-ios
//
//  Created by bakebrlk on 22.03.2025.
//

import SwiftUI
import FirebaseAuth

struct UserModel: Codable, Identifiable {
    let id: String
    var firstName: String
    var lastName: String
    let email: String
    let languageLevel: String
    let age: String
    let purpose: String
    var completedUnits: [String]
    let rank: Int
    let activityDays: [String]
    let lastActiveDate: Date
    var money: Int
    let life: Int
    
    var points: Int {
        completedUnits.count * 20
    }
    
    init(
        id: String,
        firstName: String,
        lastName: String,
        email: String,
        languageLevel: String,
        age: String,
        purpose: String,
        completedUnits: [String],
        rank: Int,
        activityDays: [String],
        lastActiveDate: Date,
        money: Int,
        life: Int
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.languageLevel = languageLevel
        self.age = age
        self.purpose = purpose
        self.completedUnits = completedUnits
        self.rank = rank
        self.activityDays = activityDays
        self.lastActiveDate = lastActiveDate
        self.money = money
        self.life = life
    }
    
    init() {
        self.id = ""
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.languageLevel = ""
        self.age = ""
        self.purpose = ""
        self.completedUnits = []
        self.rank = 0
        self.activityDays = []
        self.lastActiveDate = Date.now
        self.money = 0
        self.life = 0
    }
}

struct UserAchievements: Identifiable, Codable {
    let id: UUID
    let title: String
    let imageName: String
    
    init(id: UUID = UUID(), title: String, imageName: String) {
        self.id = id
        self.title = title
        self.imageName = imageName
    }
}
