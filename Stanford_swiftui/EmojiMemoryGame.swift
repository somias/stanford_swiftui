//
//  EmojiMemoryGame.swift
//  Stanford_swiftui
//
//  Created by Milos on 18. 8. 2023..
//

import SwiftUI

class EmojiMemoryGame {
    private static let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(
            numberOfPairsOfCard: 16) { pairIndex in
                // Protect if instead users sets more emojis than there are in the emojis array
                if emojis.indices.contains(pairIndex) {
                    return emojis[pairIndex]
                } else {
                    return "⁉️"
                }
            }
    }
    
    private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func chooseCard(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
