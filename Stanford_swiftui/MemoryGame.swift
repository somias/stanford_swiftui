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
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }

    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    // Instead of this function we can use array.firstIndex (Familiarize yourself with Array methods.)
    // We used this function in choose() but we replaced it with array.firstIndex. (Look choose function)
//    private func index(of card: Card) -> Int? {
//        for index in cards.indices {
//            if cards[index].id == card.id {
//                return index
//            }
//        }
//
//        return nil
//    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        // In Swift, when comparing each thing we don't need it because Swift will do it for us. So I will comment this code.
//        static func == (lhs: Card, rhs: Card) -> Bool {
//            return lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched && lhs.content == rhs.content
//        }
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }

    }
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
