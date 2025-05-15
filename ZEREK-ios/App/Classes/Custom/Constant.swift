//
//  Constant.swift
//  ZEREK-ios
//
//  Created by bakebrlk on 28.03.2025.
//

import SwiftUI

enum Constant {
    // MARK: Colors
    static let blue: Color = Color(red: 125/255, green: 128/255, blue: 218/255)
    static let purple: Color = Color(red: 0.545, green: 0.49, blue: 0.855)
    static let gold: Color = Color(red: 1, green: 0.796, blue: 0.278)
    static let black: Color = Color(red: 0, green: 0, blue: 0)
    static let gray: Color = Color(red: 0.671, green: 0.671, blue: 0.671)
    static let white: Color = Color(red: 0.95, green: 0.95, blue: 0.96)
    
    //MARK: Fonts
    enum ZFont: String {
        case bold = "Helvetica-Bold"
        case regular = "Helvetica"
    }
    
    //MARK: Values
    static let width: CGFloat = UIScreen.main.bounds.width
    static let radius: CGFloat = UIScreen.main.bounds.width * 0.053
    
    //MARK: Functions
    static func getText(text: String, font: ZFont, size: CGFloat) -> some View {
        Text(text)
            .font(Font.custom(font.rawValue, size: size))
    }
    
    //MARK: View
    public static func navigationHealthBar(progressValue: CGFloat, health: Int, action: @escaping () -> Void) -> some View {
        HStack {
            closeButton(action: action)
            progressView(progressValue: progressValue)
            healthView(health: health)
        }
        .padding(.horizontal)
    }
    
    private static func progressView(progressValue : CGFloat) -> some View {
        LinearProgressView(value: progressValue, shape: Capsule())
            .tint(Constant.purple)
            .frame(maxWidth: .infinity, maxHeight: Constant.radius)
            .padding(.horizontal, Constant.radius/2)
    }
    
    private static func healthView(health: Int)-> some View {
        HStack {
            Image("heart").configure
                .frame(maxWidth: Constant.radius, maxHeight: Constant.radius)
            Constant.getText(text: health.toString, font: .regular, size: Constant.radius)
        }
    }
    
    
    private static func closeButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: "xmark")
                .configure
                .frame(maxWidth: Constant.radius, maxHeight: Constant.radius)
                .foregroundColor(.primary)
        }
        
    }
}
