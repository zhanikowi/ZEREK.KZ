//
//  AudioDictionaryView.swift
//  ZEREK
//
//  Created by  Admin on 07.05.2025.
//

import SwiftUI
import AVFoundation

struct AudioDictionaryView: View {
    @StateObject private var viewModel = AudioDictionaryViewModel()
    @State private var audioPlayer: AVAudioPlayer?
    @State private var showDictionary = false
    @State private var showRespect = false
    
    var body: some View {
        ScrollView {
            ZStack {
                Constant.purple
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 275)
                
                VStack(spacing: 16) {
                    Spacer()
                    
                    VStack(spacing: 16) {
                        Image("letsLearn")
                            .resizable()
                            .frame(width: 320, height: 80)
                        
                        Button {
                            showDictionary = true
                        } label: {
                            Constant.getText(text: "Start", font: .bold, size: 24)
                                .padding(Constant.radius)
                                .frame(maxWidth: .infinity)
                                .background(Constant.gold)
                                .foregroundColor(.white)
                        }
                        .cornerRadius(Constant.radius)
                        .padding(.horizontal, 16)
                    }
                    
                    Spacer()
                }
                .padding(.top, 32)
            }
            
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .padding()
            } else if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                Spacer()
                
                VStack(spacing: 0) {
                    ForEach(viewModel.words) { word in
                        HStack(spacing: 12) {
                            Button {
                                playSound(named: word.audioFileName)
                            } label: {
                                Image("audio")
                                    .resizable()
                                    .frame(width: 38, height: 38)
                                    .foregroundColor(Constant.purple)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(word.word)
                                    .font(.system(size: 19, weight: .bold))
                                Text(word.translation)
                                    .font(.system(size: 17))
                            }
                            
                            Spacer()
                        }
                        .frame(height: 75)
                        .padding(.horizontal, 12)
                        
                        if word.id != viewModel.words.last?.id {
                            Divider().padding(.leading, 62)
                        }
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Constant.purple, lineWidth: 1)
                )
                .padding(.horizontal, 16)
            }
            
            Spacer()
        }
        .fullScreenCover(isPresented: $showDictionary) {
            DictionaryView(words: viewModel.words, onAllCardsRemoved: {
                showDictionary = false
                showRespect = true
            })
        }
        .fullScreenCover(isPresented: $showRespect) {
            FinishDictionaryView()
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Audio
    private func playSound(named: String) {
        guard let url = Bundle.main.url(forResource: named, withExtension: nil) else {
            print("Audio file \(named) not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing sound \(named): \(error)")
        }
    }
}

#Preview {
    AudioDictionaryView()
}
