//
//  CardView.swift
//  Stanford_swiftui
//
//  Created by Milos on 15. 9. 2023..
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View {
        Pie(endAngle: .degrees(240))
            .opacity(Constants.Pie.opacity)
            .overlay {
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.Pie.inset)
            }
            .padding(Constants.inset)
            .cardify(isFaceUp: card.isFaceUp)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
    
    private struct Constants {
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.5
            static let inset: CGFloat = 5
        }
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}

struct CardView_Previews: PreviewProvider {
    // Because we have added typealias in CardView
    // and typealias creates a new type
    // instead of writing: typealias Card = MemoryGame<String>.Card
    // we write it like this:
    typealias Card = CardView.Card
    
    static var previews: some View {
        // We are completely allowed to do this
        VStack {
            HStack {
                CardView(Card(isFaceUp: true,content: "x", id: "test"))
                CardView(Card(content: "x", id: "test1"))
            }
            HStack {
                CardView(Card(isFaceUp: true, isMatched: true, content: "This is a very long string, i hope it fits", id: "test"))
                CardView(Card(isMatched: true, content: "x", id: "test1"))
            }
        }
        .padding()
        .foregroundColor(.green)
    }
}
