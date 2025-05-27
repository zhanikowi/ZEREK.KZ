//
//  MainView.swift
//  ZEREK
//
//  Created by bakebrlk on 28.03.2025.
//

import SwiftUI

struct MainView: View {
    
    @State private var selectedUnit: Units? = nil

    @StateObject private var vm = MainViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                navigationBar
                
                if vm.isLoading {
                    Spacer()
                    ProgressView("Loading...")
                        .padding()
                } else if let error = vm.errorMessage {
                    Spacer()
                    Text("Ошибка: \(error)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    units
                }
                
                Spacer()
            }
            .task {
                await vm.fetchUnits()
            }
        }
        .background(Color.white)
        .fullScreenCover(item: $selectedUnit) { unit in
            LevelContainerView(unit: unit)
        }
    }
    
    private var navigationBar: some View {
        HStack {
            Image("money").configure.frame(maxWidth: 25)
            Constant.getText(text: vm.user.money?.toString ?? "", font: .regular, size: 20)
                .foregroundColor(Constant.gold)
            
            Spacer()
            Constant.getText(text: "Tasks", font: .bold, size: 20)
            Spacer()
            
            Image("heart").configure.frame(maxWidth: 25)
            Constant.getText(text: vm.user.life?.toString ?? "", font: .regular, size: 20)
        }
        .padding(.horizontal)
    }
    
    
    var units: some View {
        VStack {
            VStack {
               HStack {
                   VStack {
                       Constant.getText(text: "Units", font: .bold, size: 16)
                           .frame(maxWidth: .infinity, alignment: .leading)
                       Constant.getText(text: "Units here", font: .regular, size: 12)
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
            }
            .padding(.horizontal)
            
            ScrollView {
                ZStack {
                    VStack(spacing: 0) {
                        ForEach(vm.allunits) { unit in
                            LevelView(
                                level: unit,
                                alignment: levelViewAlignment(queue: unit.queue),
                                backgroundColor: Constant.purple) {
                                    selectedUnit = unit.units.first
                                }
                                .frame(height: 100)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.trailing, 150)
                    
                    GeometryReader { geo in
                        Image("mainPageZerek")
                            .resizable()
                            .frame(width: 150, height: 180)
                            .position(
                                x: geo.size.width - 100,
                                y: geo.size.height / 2
                            )
                    }
                }
            }
        }
    }
    
    private func levelViewAlignment(queue: Int) -> LevelView.Alignment {
        let alignment: LevelView.Alignment
        switch (queue - 1) % 4 {
            case 0: alignment = .right
            case 1, 3: alignment = .center
            case 2: alignment = .left
            default: alignment = .center
        }
        return alignment
    }
}

#Preview {
    MainView()
}
