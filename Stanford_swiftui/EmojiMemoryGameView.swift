//
//  ContentView.swift
//  Stanford_swiftui
//
//  Created by Milos on 16. 8. 2023..
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
    
    var body: some View {
        VStack {
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
                    
            }.scrollIndicators(.hidden)
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }.padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.chooseCard(card)
                    }
            }
        }  .foregroundColor(.orange)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            // Reason I can use variable like this is because of ViewBuilder
            // let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            // But beacuse of "Type Inference" we don't need to explicitly write Type.
            let base = RoundedRectangle(cornerRadius: 12)
            // But ViewBuilder only can do If's (conditionals, also Switch), lists and local variables.
            
            // Use Group to "group" together statements and add modifiers. Instead of adding opacity on every line inside Group, I just add Opacity as Group modifier.
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }.opacity(card.isFaceUp ? 1 : 0)
            
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
    }
}



















struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
