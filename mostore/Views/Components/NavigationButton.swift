//
//  NavigationButton.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-19.
//

import SwiftUI

struct NavigationButton: View {
    let name:  any View
    let destination: AnyView
    let topPadding: Double
    let acColor: Color
    let bgColor: Color
    let corner: CGFloat
    let fontSize: Font
    @Binding var isMovable: Bool
    let action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }, label: {
            AnyView(name)

        })
        .padding(.vertical, topPadding)
        .accentColor(acColor)
        .font(fontSize)
        .fontWeight(.bold)
        .frame(maxWidth: .infinity)
        .background(bgColor)
        .cornerRadius(corner)
        .navigationDestination(isPresented: $isMovable) {
            destination
        }
    }
}

struct NavigationButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationButton(
            name: Text("Navigate"), destination: AnyView(ProductView()), topPadding: 8, acColor: .white, bgColor: .blue, corner: 8, fontSize: .title, isMovable: Binding(get: { false }, set: { _ in })
        ){}
    }
}
