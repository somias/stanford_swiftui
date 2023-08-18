//
//  MemorizeGame.swift
//  Stanford_swiftui
//
//  Created by Milos on 18. 8. 2023..
//

import Foundation

// CardContent is Generic (Generics are part of Swift language)
struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCard: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCard x 2 cards
        // max(2, numberOfPairsOfCard) - at least 2 pairs of cards
        for pairIndex in 0..<max(2, numberOfPairsOfCard) {
            let cardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: cardContent))
            cards.append(Card(content: cardContent))
        }
    }

    func choose(_ card: Card) {
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}
