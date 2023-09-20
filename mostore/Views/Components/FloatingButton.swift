//
//  FloatingButton.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-15.
//

import SwiftUI

struct FloatingButton: View {
    let icon: String
    let fg: Color
    let bg: Color
    let label: String
    let action: () -> Void
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button { action() }
            label: {
                        Image(systemName: icon)
                            .font(.system(size: 25))
                            .foregroundColor(fg)
                    }
                    .frame(width: 60, height: 60)
                    .accessibilityLabel(label)
                    .background(bg)
                    .cornerRadius(30)
                    .shadow(radius: 10)
                    .offset(x: -25, y: 10)
            }
        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton(
            icon: "cart.badge.plus", fg: Color.white, bg: Color.blue, label: "Add to cart"
        ) {}
    }
}
