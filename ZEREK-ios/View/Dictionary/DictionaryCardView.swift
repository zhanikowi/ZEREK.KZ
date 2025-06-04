//
//  DictionaryCardView.swift
//  ZEREK
//
//  Created by  Admin on 06.05.2025.
//

import SwiftUI

struct DictionaryCardView: View {
    let card: AudioDictionaryModel
    let onRemove: () -> Void
    
    @State private var isFlipped = false
    @State private var offset = CGSize.zero
    
    var body: some View {
        ZStack {
            ZStack {
                Image("cardFrontSide")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 235, height: 370)
                    .clipped()
                    .cornerRadius(8)
                    .shadow(radius: 4)
                
                VStack {
                    Text(card.word)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                }
            }
            .opacity(isFlipped ? 0 : 1)
            
            ZStack {
                Image("cardBackSide")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 235, height: 370)
                    .clipped()
                    .cornerRadius(8)
                    .shadow(radius: 4)
                
                VStack(spacing: 12) {
                    Text(card.translation)
                        .font(.largeTitle)
                        .foregroundColor(Constant.purple)
                        .bold()
                    
                    Text(card.word)
                        .font(.title3)
                        .foregroundColor(.gray)
                }
            }
            .opacity(isFlipped ? 1 : 0)
            .scaleEffect(x: -1, y: 1)
        }
        .frame(width: 320, height: 420)
        .rotation3DEffect(
            .degrees(isFlipped ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
        .offset(x: offset.width, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                } .onEnded { _ in
                    withAnimation {
                        swipeCard(width: offset.width)
                    }
                }
        )
        .onTapGesture {
            withAnimation(.spring()) {
                isFlipped.toggle()
            }
        }
    }
    
    private func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150), 150...500:
            offset = CGSize(width: width > 0 ? 500 : -500, height: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                onRemove()
            }
        default:
            offset = .zero
        }
    }
}
