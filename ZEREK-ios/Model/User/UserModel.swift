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
    var money: Int? = 50
    var life: Int? = 5
    var level: Int? = 1
    var rank: Int? = 25
    var activeDay: Int? = 22
    var achievements: [UserAchievements]? = []
    
    init() {
        self.id = ""
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.languageLevel = ""
        self.age = ""
        self.purpose = ""
    }
    
    init(id: String, firstName: String, lastName: String, email: String, languageLevel: String, age: String, purpose: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.languageLevel = languageLevel
        self.age = age
        self.purpose = purpose
        self.activeDay = 22
        self.achievements = [
            UserAchievements(title: "Smooth Talker", imageName: "GlowingStar"),
            UserAchievements(title: "Daily Streak Keeper", imageName: "Trophy"),
            UserAchievements(title: "Fast learner", imageName: "Warranty"),
            UserAchievements(title: "Smooth Talker", imageName: "GlowingStar"),
            UserAchievements(title: "Daily Streak Keeper", imageName: "Trophy"),
            UserAchievements(title: "Fast learner", imageName: "Warranty")
            
        ]
    }
    
    init?(dictionary: [String : Any]) {
        guard let id = dictionary["id"] as? String,
              let firstName = dictionary["firstName"] as? String,
              let lastName = dictionary["lastName"] as? String,
              let email = dictionary["email"] as? String,
              let languageLevel = dictionary["languageLevel"] as? String,
              let age = dictionary["age"] as? String,
              let purpose = dictionary["purpose"] as? String
        else {
            return nil
        }
        
        if let money = dictionary["money"] as? Int {
            self.money = money
        }
        
        if let life = dictionary["life"] as? Int{
            self.life = life
        }
        
        if let level = dictionary["level"] as? Int{
            self.level = level
        }
        
        if let rank = dictionary["rank"] as? Int{
            self.rank = rank
        }
        
        if let activeDay = dictionary["activeDay"] as? Int {
            self.activeDay = activeDay
        }
        
        if let achievements = dictionary["achievements"] as? [UserAchievements] {
            self.achievements = achievements
        }
        
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.languageLevel = languageLevel
        self.age = age
        self.purpose = purpose
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
