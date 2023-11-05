//
//  Board.swift
//  SpellingBee
//
//  Created by Daniel Owens on 11/4/23.
//

import SwiftUI

struct InputDisplay: View {
    let tappedLetters: [String]
    
    var body: some View {
        VStack {
            Text(tappedLetters.joined(separator: ""))
                .font(.title)
        }
    }
}

struct HexagonBoard: View {
    @State private var letters: [String] = [] // Store the letters as a state variable
    @State private var tappedHexagonIndex: Int?
    
    var body: some View {
        VStack {
            Board(letters: $letters, tappedHexagonIndex: $tappedHexagonIndex, tappedLetters: $letters) // Pass the binding of `letters`
            InputDisplay(tappedLetters: letters)
        }
    }
}

struct Board: View {
    @Binding var letters: [String]
    @Binding var tappedHexagonIndex: Int?
    @Binding var tappedLetters: [String]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let hexSize: CGFloat = 80
                let hexSpacing: CGFloat = 0
                
                // Render the center hexagon
                Hexagon()
                    .fill(Color.yellow)
                    .frame(width: hexSize, height: hexSize)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    .rotationEffect(.degrees(0))
                    .overlay(Text(letters[0]).foregroundColor(.black).position(x: geometry.size.width / 2, y: geometry.size.height / 2))
                    .gesture(TapGesture()
                        .onEnded {
                            tappedHexagonIndex = 0
                            if (tappedLetters.count > 20) {
                                tappedLetters = []
                            }
                            else {
                                tappedLetters.append(letters[0])
                            }
                           
                        }
                    )
                
                // Loop through the rest of the letters
                ForEach(1..<letters.count, id: \.self) { index in
                    // Render additional hexagons
                    Hexagon()
                        .fill(Color.gray)
                        .frame(width: hexSize, height: hexSize)
                        .position(
                            x: geometry.size.width / 2 + (hexSize + hexSpacing) * cos(.pi / 3 + CGFloat.pi / 3 * CGFloat(index - 1)),
                            y: geometry.size.height / 2 + (hexSize + hexSpacing) * sin(.pi / 3 + CGFloat.pi / 3 * CGFloat(index - 1))
                        )
                        .overlay(Text(letters[index]).foregroundColor(.black).position(
                            x: geometry.size.width / 2 + (hexSize + hexSpacing) * cos(.pi / 3 + CGFloat.pi / 3 * CGFloat(index - 1)),
                            y: geometry.size.height / 2 + (hexSize + hexSpacing) * sin(.pi / 3 + CGFloat.pi / 3 * CGFloat(index - 1))
                        ))
                        .gesture(TapGesture()
                            .onEnded {
                                tappedHexagonIndex = index
                                if ( tappedLetters.count > 20 ) {
                                    tappedLetters = []
                                }
                                else {
                                    tappedLetters.append(letters[index])
                                }
                            }
                        )
                }
            }
        }
        .background(Color.white)
    }
}

