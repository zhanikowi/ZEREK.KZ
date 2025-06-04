//
//  LevelView.swift
//  ZEREK
//
//  Created by bakebrlk on 28.03.2025.
//

import SwiftUI

struct LevelView: View {
    enum Alignment {
        case left
        case right
        case center

        var alignment: SwiftUI.Alignment {
            switch self {
            case .left: return .leading
            case .right: return .trailing
            case .center: return .center
            }
        }
    }
    
    let level: UnitsModel
    let alignment: Alignment
    let backgroundColor: Color
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            Image(level.iconName)
                .resizable()
                .frame(maxWidth: 70)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(backgroundColor.opacity(0.9))
                            .frame(width: 70, height: 65)
                            .offset(y: 12)

                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(backgroundColor)
                            .frame(width: 70, height: 65)
                    }
                )
        }
        .frame(maxWidth: .infinity, alignment: alignment.alignment)
    }
}

