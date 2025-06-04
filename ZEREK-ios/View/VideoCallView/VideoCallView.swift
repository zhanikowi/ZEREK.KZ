//
//  VideoCallView.swift
//  ZEREK
//
//  Created by  Admin on 07.05.2025.
//

import SwiftUI

struct TeachersModel: Identifiable {
    let id = UUID()
    let name: String
    let phoneNumber: String
}

struct VideoCallView: View {
    @StateObject private var viewModel = VideoCallViewModel()
    @State private var showTeacherList = false
    @State private var selectedTeacher: TeachersModel?
    
    private let teachers: [TeachersModel] = [
        .init(name: "Gaisha Aripkhan", phoneNumber: "+77711619146"),
        .init(name: "Gulzhanat Toraliyeva", phoneNumber: "+77757969603"),
        .init(name: "Nuray Zhumabay", phoneNumber: "+77751314805")
    ]
    
    private let calls: [VideoCallModel] = [
        .init(callName: "Gaisha Aripkhan", callDuration: "3 min"),
        .init(callName: "Gulzhanat Toraliyeva", callDuration: "4 min"),
        .init(callName: "Nuray Zhumabay", callDuration: "1 min")
    ]
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                ZStack {
                    Constant.purple
                        .ignoresSafeArea(edges: .top)
                        .frame(height: 300)
                    
                    ZStack(alignment: .bottomLeading) {
                        Image("videocall")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 320, height: 220)
                            .cornerRadius(16)
                        
                        Button {
                            showTeacherList = true
                        } label: {
                            Constant.getText(text: "Start", font: .regular, size: 20)
                                .frame(width: 120, height: 44)
                                .background(Color.black.opacity(0.7))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.bottom, 16)
                    }
                }
                
                Text("Call history")
                    .font(.system(size: 24, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(calls) { call in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(call.callName)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text(call.callDuration)
                                    .font(.system(size: 16))
                                    .foregroundColor(.white.opacity(0.9))
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.yellow)
                            .cornerRadius(20)
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.top, 8)
                }
                
                Spacer()
            }
            .sheet(isPresented: $showTeacherList) {
                TeacherSelectionFullScreenView(teachers: teachers) { teacher in
                    showTeacherList = false
                    viewModel.tryToStartCall(phoneNumber: teacher.phoneNumber) {
                        startFaceTime(phoneNumber: teacher.phoneNumber)
                    }
                }
            }
            .task {
                await viewModel.loadUser()
            }
            
            if viewModel.showAlert {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                
                CustomAlertView(
                    title: "Attention",
                    message: viewModel.alertMessage,
                    buttonTitle: "OK"
                ) {
                    withAnimation {
                        viewModel.showAlert = false
                    }
                }
                .transition(.scale)
            }
        }
    }
    
    private func startFaceTime(phoneNumber: String) {
        guard let facetimeURL = URL(string: "facetime://\(phoneNumber)") else { return }
        if UIApplication.shared.canOpenURL(facetimeURL) {
            UIApplication.shared.open(facetimeURL)
        } else {
            print("Cannot open FaceTime")
        }
    }
}


#Preview {
    VideoCallView()
}

struct TeacherSelectionFullScreenView: View {
    let teachers: [TeachersModel]
    let onSelect: (TeachersModel) -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea()
            
            VStack {
                ZStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.primary)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 32)
                    
                    Text("Select a teacher")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.top, 32)
                }
                
                Spacer()
                
                VStack(spacing: 16) {
                    ForEach(teachers) { teacher in
                        Button {
                            onSelect(teacher)
                        } label: {
                            Text(teacher.name)
                                .foregroundColor(.black)
                                .font(.system(size: 18))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Constant.purple, lineWidth: 1)
                                )
                        }
                    }
                }
                .padding(24)
                
                Spacer()
            }
        }
    }
}


