//
//  AudioDictionaryViewModel.swift
//  ZEREK
//
//  Created by  Admin on 01.06.2025.
//

import Foundation

final class AudioDictionaryViewModel: ObservableObject {
    @Published var words: [AudioDictionaryModel] = []
    @Published var isLoading = false
    @Published var error: String?

    init() {
        fetchWords()
    }

    func fetchWords() {
        isLoading = true
        error = nil

        ServerManager.fetchAudioDictionaryWords { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let fetchedWords):
                    self.words = fetchedWords
                case .failure(let err):
                    self.error = "Failed to load words: \(err.localizedDescription)"
                }
            }
        }
    }
}
