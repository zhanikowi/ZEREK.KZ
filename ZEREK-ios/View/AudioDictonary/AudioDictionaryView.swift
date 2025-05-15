//
//  AudioDictionaryView.swift
//  ZEREK
//
//  Created by  Admin on 07.05.2025.
//

import SwiftUI
import AVFoundation

struct AudioDictionaryView: View {
    @State private var audioPlayer: AVAudioPlayer?
    @State private var showDictionary = false
    @State private var showRespect = false

    private let words: [AudioDictionaryModel] = [
        .init(word: "кітап", translation: "book", audioFileName: "book.mp3"),
        .init(word: "сынып", translation: "group", audioFileName: "group.mp3"),
        .init(word: "дәптер", translation: "notebook", audioFileName: "notebook.mp3"),
        .init(word: "мектеп", translation: "school", audioFileName: "school.mp3"),
        .init(word: "біз", translation: "we", audioFileName: "we.mp3")
    ]

    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Color.purple
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 200)

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
            }

            VStack(spacing: 0) {
                ForEach(words) { word in
                    HStack(spacing: 12) {
                        Button {
                            playSound(named: word.audioFileName)
                        } label: {
                            Image("audio")
                                .resizable()
                                .frame(width: 38, height: 38)
                                .foregroundColor(.purple)
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

                    if word.id != words.last?.id {
                        Divider()
                            .padding(.leading, 62)
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.purple, lineWidth: 1)
            )
            .padding(.horizontal, 16)

            Spacer()
        }
        .fullScreenCover(isPresented: $showDictionary) {
            DictionaryView {
                showDictionary = false
                showRespect = true
            }
        }
        .fullScreenCover(isPresented: $showRespect) {
            FinishDictionaryView()
        }
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
