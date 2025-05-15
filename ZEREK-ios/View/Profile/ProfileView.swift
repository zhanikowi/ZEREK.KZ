//
//  ProfileView.swift
//  ZEREK
//
//  Created by bakebrlk on 18.04.2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var vm: MainViewModel
    @EnvironmentObject var navigation: Navigation

    private var bg: some View {
        VStack {
            WaveShape()
                .fill(Constant.purple)
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/2.68)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var topBar: some View {
        ZStack {
            HStack {
                Spacer()
                
                Button {
                    navigation.navigate(to: .settings)
                } label: {
                    Image(systemName: "gearshape")
                        .configure
                        .frame(maxWidth: Constant.radius, maxHeight: Constant.radius)
                }
            }

            Constant.getText(text: "Profile", font: .bold, size: Constant.radius)
        }
        .foregroundColor(.white)
        .padding(Constant.radius)
        .padding(.top, Constant.radius * 2)
    }
    
    private var profileInfoView: some View {
        HStack {
            Image("Profile")
                .configure
                .padding([.top, .horizontal], Constant.radius/2)
                .frame(maxWidth: Constant.radius * 5, maxHeight:  Constant.radius * 5)
                .background(
                    Circle()
                        .fill(Color(.systemGray4))
                )
            
            VStack(alignment: .leading) {
                Constant.getText(text: vm.user.firstName + " " + vm.user.lastName,
                                 font: .bold,
                                 size: 19)
                
                Constant.getText(text: "Native language: English", font: .regular, size: 14)
            }
            .frame(maxWidth: Constant.width/2)
            .foregroundColor(.white)
            .padding(.horizontal, Constant.radius/2)
            
            Spacer()
            
            VStack {
                Image("kz").configure
                    .frame(maxWidth: Constant.radius, maxHeight: Constant.radius)
                
                Constant.getText(text: vm.user.languageLevel, font: .regular, size: 20)
                    .foregroundColor(Constant.gold)
            }
        }
        .padding(.horizontal, Constant.radius)
    }
    
    private var progressView: some View {
        RingProgressView(progress: 0.58)
            .padding(Constant.radius)
            .frame(maxWidth: Constant.width/2.8)
            .cornerRadius(Constant.radius)
    }
    
    private func userProgressConfigure(title: String, image: Image, score: String) -> some View {
        VStack(alignment: .leading) {
            Constant.getText(text: title, font: .regular, size: 11)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, Constant.radius * 0.2)
            HStack {
                image
                    .foregroundColor(Constant.gold)
                Constant.getText(text: score, font: .regular, size: 18)
            }
        }
        .padding(.vertical,Constant.radius)
        .padding(.horizontal, Constant.radius)
        .frame(maxWidth: Constant.width/3.3, maxHeight: UIScreen.main.bounds.height/11.6)
        .background(Constant.purple)
        .foregroundColor(.white)
        .cornerRadius(Constant.radius/2)
    }
    
    private var userProgressInfo: some View {
        HStack {
            userProgressConfigure(
                title: "Completed level",
                image: Image("biceps-flexed"),
                score: "\(vm.user.level ?? 1)"
            )
            
            userProgressConfigure(
                title: "Score",
                image: Image("money"),
                score: "\(vm.user.money ?? 0)"
            )
            
            userProgressConfigure(
                title: "Words",
                image: Image(systemName: "book"),
                score: "\(vm.user.rank ?? 0)"
            )
        }
    }
    
    private func dailyStatus(status: Bool? = nil) -> some View {
        Image((status != nil) ? (status! ? "flame" : "x") : "")
            .configure
            .padding(Constant.radius * 0.1)
            .frame(maxWidth: Constant.radius * 1.5)
            .background(
                Circle()
                    .fill(Constant.purple.opacity(0.8))
            )
    }
    
    private var dailyActivity: some View {
        VStack {
            Constant.getText(text: "Your daily activity", font: .bold, size: 17)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: Constant.radius) {
                ForEach(1...7, id: \.self) { day in
                    dailyStatus(status: vm.user.activeDay ?? 0 > day)
                }
            }
            .padding(.top, Constant.radius/2)
            
            HStack {
                Image(systemName: "calendar")
                    .configure
                    .frame(maxWidth: Constant.radius * 1.3)
                    .foregroundColor(.black)
                
                Constant.getText(text: "\(vm.user.activeDay ?? 0) active days",
                                 font: .regular, size: 12)
            }
            .padding(.top, Constant.radius/2)
        }
        .padding([.top, .horizontal], Constant.radius)
    }
    
    private func achievementsConfigure(achievement: UserAchievements) -> some View {
        VStack {
            Image(achievement.imageName)
                .configure
                .frame(maxWidth: Constant.radius * 2.3, maxHeight: Constant.radius * 2.3)
            
            Constant.getText(text: achievement.title, font: .regular, size: 15)
                .foregroundColor(.white)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
        .padding(Constant.radius/2)
        .frame(maxWidth: Constant.width / 3.1, maxHeight: UIScreen.main.bounds.height / 8.64)
        .background(Constant.purple)
        .cornerRadius(Constant.radius)
    }
    
    private var achievements: some View {
        Group {
            if let achievements: [UserAchievements] = vm.user.achievements {
                VStack {
                    Constant.getText(text: "Achievements", font: .bold, size: 17)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(achievements) { achievement in
                                achievementsConfigure(achievement: achievement)
                            }
                        }
                    }
                }
                .padding([.top, .horizontal], Constant.radius)
            }else {
                VStack{}
            }
        }
    }
    
    var body: some View {
        ZStack {
            bg
            
            if vm.isAuthorized {
                VStack {
                    topBar
                    profileInfoView
                    progressView
                    userProgressInfo
                    dailyActivity
                    achievements
                    Spacer()
                }
            } else {
                VStack {
                    Spacer()
                    Button(action: {
                        navigation.navigate(to: .signIn)
                    }) {
                        Constant.getText(text: "Login/Sign Up",
                                         font: .bold,
                                         size: Constant.radius)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Constant.purple)
                        .foregroundColor(.white)
                        .cornerRadius(Constant.radius)
                        .padding(.horizontal, Constant.radius)
                    }
                    Spacer()
                }
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ProfileView()
}

struct WaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height * 0.7))
        path.addCurve(
            to: CGPoint(x: rect.width, y: rect.height * 0.7),
            control1: CGPoint(x: rect.width * 0.25, y: rect.height),
            control2: CGPoint(x: rect.width * 0.75, y: rect.height * 0.4)
        )
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.closeSubpath()
        
        return path
    }
}

import SwiftUI

struct RingProgressView: View {
    var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 20)
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(Constant.purple, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 0.8), value: progress)
            
            VStack(spacing: 4) {
                Text("\(Int(progress * 100))%")
                    .font(.headline)
                    .bold()
                Text("of level")
                    .font(.subheadline)
                    .foregroundColor(.black.opacity(0.7))
            }
        }
    }
}
