//
//  Stanford_swiftuiApp.swift
//  Stanford_swiftui
//
//  Created by Milos on 16. 8. 2023..
//

import SwiftUI

@main
struct Stanford_swiftuiApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
