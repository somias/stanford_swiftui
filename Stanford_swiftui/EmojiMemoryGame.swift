//
//  EmojiMemoryGame.swift
//  Stanford_swiftui
//
//  Created by Milos on 18. 8. 2023..
//

import SwiftUI

// This is a ViewModel
class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(
            numberOfPairsOfCard: 2) { pairIndex in
                // Protect if instead users sets more emojis than there are in the emojis array
                if emojis.indices.contains(pairIndex) {
                    return emojis[pairIndex]
                } else {
                    return "⁉️"
                }
            }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        model.cards
    }
    
    var color: Color {
        .orange
    }
    
    // MARK: - Intents

    func shuffle() {
        model.shuffle()
    }
    
    func chooseCard(_ card: Card) {
        model.choose(card)
    }
}
