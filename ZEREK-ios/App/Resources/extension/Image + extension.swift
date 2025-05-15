//
//  Image + extension.swift
//  ZEREK
//
//  Created by bakebrlk on 28.03.2025.
//

import SwiftUI

extension Image {
    var configure: some View {
        self
            .resizable()
            .scaledToFit()
    }
}
