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
        
        var edge: Edge.Set {
            switch self {
            case .left: return .trailing
            case .right: return .leading
            }
        }
    }
    
    let level: LevelModel
    let alignment: Alignment
    let padding: CGFloat
    let backgroundColor: Color
    
    var body: some View {
        Button {
            print(level.id)
        } label: {
            Image(level.image)
                .resizable()
                .frame(maxWidth: 70)
                .padding(.bottom)
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
                )        }
        .padding(alignment.edge, padding)
        .disabled(backgroundColor == Constant.gray)
    }
}

