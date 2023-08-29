//
//  LayoutPlayground.swift
//  Stanford_swiftui
//
//  Created by Milos on 28. 8. 2023..
//

import SwiftUI

struct LayoutPlayground: View {
    var body: some View {
        ZStack(alignment: .top) {
            Text("Important")
            Spacer()
            ZStack {
                    Text("Hello")
            }
//            Image(systemName: "arrow.up")
//            Text("Unimportant")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemCyan))
    }
}

struct LayoutPlayground_Previews: PreviewProvider {
    static var previews: some View {
        LayoutPlayground()
    }
}
