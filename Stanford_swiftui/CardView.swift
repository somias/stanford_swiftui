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
        ZStack {
            // Reason I can use variable like this is because of ViewBuilder
            // let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            // But beacuse of "Type Inference" we don't need to explicitly write Type.
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            // But ViewBuilder only can do If's (conditionals, also Switch), lists and local variables.
            
            // Use Group to "group" together statements and add modifiers. Instead of adding opacity on every line inside Group, I just add Opacity as Group modifier.
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: Constants.lineWidth)
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
            }.opacity(card.isFaceUp ? 1 : 0)
            
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }.opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
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
