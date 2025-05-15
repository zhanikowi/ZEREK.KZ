//
//  MainView.swift
//  ZEREK
//
//  Created by bakebrlk on 28.03.2025.
//

import SwiftUI

struct MainView: View {
    
    @State private var showLevels: Bool = false
    
    @ObservedObject private var vm: MainViewModel = MainViewModel()
    
    private var navigationBar: some View {
        HStack {
            Image("money")
                .configure
                .frame(maxWidth: 25)
            
            Constant.getText(text: vm.user.money!.toString, font: .regular, size: 20)
                .foregroundColor(Constant.gold)
            
            Spacer()
            Constant.getText(text: "Tasks", font: .bold, size: 20)
            
            Spacer()
            Image("heart")
                .configure
                .frame(maxWidth: 25)
            
            Constant.getText(text: vm.user.life!.toString, font: .regular, size: 20)
        }
        .padding(.horizontal)
    }
    
    private func unitConfig(unit: UnitModel, isLeft: Bool) -> some View{
         VStack {
            HStack {
                VStack {
                    Constant.getText(text: "Unit \(unit.title)", font: .bold, size: 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Constant.getText(text: unit.description, font: .regular, size: 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 5)
                }
                
                Spacer()
                
                Image(systemName: "text.book.closed.fill")
                    .configure
                    .frame(maxWidth: 14)
                    .padding(7)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Constant.black.opacity(0.2), lineWidth: 1)
                    }
                    .shadow(color: Constant.black.opacity(0.2), radius: 10, x: 1, y: 1)
            }
            .padding()
            .background(Constant.gold)
            .foregroundColor(Constant.white)
            .cornerRadius(16)
            .padding(.top)
            .onTapGesture {
                showLevels = true
            }
            
            levelsConfig(levels: unit.levels,
                         isLeft: isLeft,
                         unitCount: unit.title)
        }
        .padding(.horizontal)
    }
    
    private func levelsConfig(levels: [LevelModel], isLeft: Bool, unitCount: Int) -> some View {
        let count = ((unitCount - 1) * 5)
        
        return LazyVStack {
            ForEach(Array(levels.enumerated()), id: \.element.id) { index, level in
                levelView(for: level, at: index, isLeft: isLeft, count: count)
            }
        }
    }

    private func levelView(for level: LevelModel, at index: Int, isLeft: Bool, count: Int) -> some View {
        let padding: CGFloat = index > 2 ? 120 * CGFloat(4 - index) : 120 * CGFloat(index)
        let backgroundColor = vm.user.level! >= (index + count) ? Constant.purple : Constant.gray
        
        return LevelView(
            level: level,
            alignment: isLeft ? .left : .right,
            padding: padding,
            backgroundColor: backgroundColor
        )
    }


    private func unitImage(name: String, isLeft: Bool) -> some View {
        Image(name).configure
            .frame(maxWidth: Constant.width * 0.27)
            .padding(isLeft ? .leading : .trailing, Constant.width * 0.47)
            .padding(.top, Constant.width * 0.3)
    }

    public var units: some View {
        
        return ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(vm.units) { unit in
                    let isLeft = unit.title % 2 == 0

                    ZStack {
                        unitImage(name: unit.imageName, isLeft: isLeft)
                        unitConfig(unit: unit, isLeft: isLeft)
                    }
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                navigationBar
                units
                Spacer()
            }
            .onAppear {
                vm.fetchUnit()
            }
        }
        .fullScreenCover(isPresented: $showLevels) {
            LevelContainerView()
        }
    }
}

#Preview {
    MainView()
}
