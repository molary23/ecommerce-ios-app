//
//  TitleToolBarItem.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-10-25.
//

import SwiftUI

struct TitleToolBarItem: View {
    let title: String
    var color: Color?
    var body: some View {
        Text(title)
            .font(.title3)
            .bold()
            .foregroundColor(color == nil ? .blue : color)
    }
}

#Preview {
    TitleToolBarItem(title: PAGE_TEXT["text"]![0], color: .blue)
}
