//
//  ContentView.swift
//  Stanford_swiftui
//
//  Created by Milos on 16. 8. 2023..
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
    @State private var cardCount: Int = 4

    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }.scrollIndicators(.hidden)
            Spacer()
             cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }  .foregroundColor(.orange)
    }

        var cardCountAdjusters: some View {
            HStack {
                cardRemover
                Spacer()
                cardAdder
            }.padding()
        }
    
    
        func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
            Button {
                cardCount += offset
            } label: {
                Image(systemName: symbol)
            }
            .imageScale(.large)
            .font(.largeTitle)
            .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
        }
    
        var cardRemover: some View {
            cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
        }
    
        var cardAdder: some View {
            cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
        }
}

struct CardView: View {
    // Views are immutable and to change the value I need to use @State variable.
    @State var isFaceUp = false
    let content: String
    
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
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            // onTapGesture has argument "count" which decides how many times View needs to be tapped to execute onTapGesture function. Default count is 1.
            isFaceUp.toggle()
        }
    }
}



















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
