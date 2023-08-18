//
//  Assignment_1.swift
//  Stanford_swiftui
//
//  Created by Milos on 18. 8. 2023..
//

import SwiftUI

let halloweenEmojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
let spaceEmojis = ["🚀", "🌌", "🪐", "🛰️", "🌠", "🌕", "👾", "👽", "🌍", "🔭", "🌘", "🌑"]
let natureEmojis = ["🌿", "🌸", "🍃", "🌻", "🌳", "🌺", "🐝", "🦋", "🐞", "🍂", "🍁", "🌼"]

struct Assignment_1: View {
    
    @State private var emojis: [String] = halloweenEmojis
    @State private var selectedTheme: [String] = halloweenEmojis
    @State private var cardCount: Int = 4
    
    private var emojiThemeColor: Color {
        switch selectedTheme {
        case spaceEmojis:
            return .blue
        case natureEmojis:
            return .green
        case halloweenEmojis:
            return .orange
        default:
            return .orange
        }
    }
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }.scrollIndicators(.hidden)
            Spacer()
            themeButtons
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
            ForEach(emojis, id: \.self) { emoji in
                CardView(content: emoji)
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }  .foregroundColor(emojiThemeColor)
    }
    
    var themeButtons: some View {
        HStack {
            themeButtonCreator(for: halloweenEmojis, symbol: "theatermasks.fill", title: "Halloween")
            Spacer()
            themeButtonCreator(for: spaceEmojis, symbol: "moon.stars.fill", title: "Space")
            Spacer()
            themeButtonCreator(for: natureEmojis, symbol: "leaf.fill", title: "Nature")
            
        }.padding(.horizontal)
    }
    
    func themeButtonCreator(for theme: [String], symbol: String, title: String) -> some View {
        Button {
            selectedTheme = theme
            emojis = theme.shuffled()
        } label: {
            VStack {
                Image(systemName: symbol)
                Text(title).font(.subheadline)
            }
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
}

struct Assignment1CardView: View {
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

struct Assignment_1_Previews: PreviewProvider {
    static var previews: some View {
        Assignment_1()
    }
}
