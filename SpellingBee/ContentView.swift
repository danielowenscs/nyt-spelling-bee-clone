//
//  ContentView.swift
//  SpellingBee
//
//  Created by Daniel Owens on 11/4/23.
//

import SwiftUI

struct ContentView: View {
    @State private var letters: [String] = ["A", "M", "O", "K", "L", "I", "G"]
    @State private var tappedLetters: [String] = []
    @State private var tappedHexagonIndex: Int?
    
    var body: some View {
        VStack (spacing: 0){
            InputDisplay(tappedLetters: tappedLetters)
            Board(letters: $letters, tappedHexagonIndex: $tappedHexagonIndex, tappedLetters: $tappedLetters)
                .aspectRatio(1.0, contentMode: .fit)
        }
    }
}

