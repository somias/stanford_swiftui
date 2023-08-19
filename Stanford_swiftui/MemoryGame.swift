//
//  MemorizeGame.swift
//  Stanford_swiftui
//
//  Created by Milos on 18. 8. 2023..
//

import Foundation

// CardContent is Generic (Generics are part of Swift language)
// Because CardContent is Generic ("we don't care for Type), because of our use of Equatable protocol in Card struct we need to implement Equatable for CardContent too. And the way to do that is like this: where CardContent: Equatable
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCard: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCard x 2 cards
        // max(2, numberOfPairsOfCard) - at least 2 pairs of cards
        for pairIndex in 0..<max(2, numberOfPairsOfCard) {
            let cardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: cardContent, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: cardContent, id: "\(pairIndex + 1)b"))
        }
    }

    mutating func choose(_ card: Card) {
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp.toggle()
    }
    
    func index(of card: Card) -> Int {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        
        return 0 // FIXME: Bogus !!
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        // In Swift, when comparing each thing we don't need it because Swift will do it for us. So I will comment this code.
//        static func == (lhs: Card, rhs: Card) -> Bool {
//            return lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched && lhs.content == rhs.content
//        }
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }

    }
}
