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
            HStack {
                ForEach(0..<cardCount, id: \.self) { index in
                    CardView(content: emojis[index])
                }
            }  .foregroundColor(.orange)
            
            HStack {
                Button {
                    cardCount -= 1
                } label: {
                    Image(systemName: "rectangle.stack.badge.minus.fill")
                }
                .imageScale(.large)
                .font(.largeTitle)
                
                Spacer()
                
                Button {
                    cardCount += 1
                } label: {
                    Image(systemName: "rectangle.stack.badge.plus.fill")
                }
                .imageScale(.large)
                .font(.largeTitle)
            }.padding()
        }
        .padding()
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
            
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base.fill()
            }
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
