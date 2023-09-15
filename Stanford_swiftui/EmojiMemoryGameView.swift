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
    
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    
    var body: some View {
        VStack {
            cards
                .animation(.default, value: viewModel.cards)
            
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }.padding()
    }
    
    //    @ViewBuilder
    private var cards: some View {
        // "cards" is a function that returns "some View", and if we want to have variables delcared like aspectRatio. We need to add @ViewBuilder to this function.
        // This is just example, we will create aspectRatio we will put on top and declare it as normal variable.
        //  let aspectRatio: CGFloat = 2/3
        
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(spacing)
                .onTapGesture {
                    viewModel.chooseCard(card)
                }
        }  .foregroundColor(.orange)
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        // Calling EmojiMemoryGame like this here is only recommended for Previews.
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
