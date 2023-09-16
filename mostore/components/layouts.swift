//
//  layout.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-24.
//

import Foundation
import SwiftUI

struct ExtTextFieldView: View {
    let placeholder: String
    let placement: TextAlignment
    let id: String
    @Binding var value: String
    var body: some View {
        TextField(placeholder, text: $value)
            .accessibilityLabel(placeholder)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .trailing)
            .multilineTextAlignment(placement)
            .id(id)
    }
}


struct ExtButtonView: View {
    let name: String
    @Binding var response: Any
    let onRequestDone: Any
    let topPadding: Double
    let acColor: Color
    let bgColor: Color
    let corner: CGFloat
    let size: Font
    var body: some View {
        Button(action: {
            response = onRequestDone
        }, label: {
            Text(name)
                .frame(maxWidth: .infinity)

        })
        .padding(.vertical, topPadding)
        .accentColor(acColor)
        .font(size)
        .fontWeight(.bold)
        .frame(maxWidth: .infinity)
        .background(bgColor)
        .cornerRadius(corner)
    }
}

struct ExtNavButtonView: View {
    let name: String
    @Binding var isMovable: Bool
    let isActive: Bool
    let destination: AnyView
    let topPadding: Double
    let acColor: Color
    let bgColor: Color
    let corner: CGFloat
    let size: Font
    var body: some View {
        Button(action: {
            isMovable = isActive
        }, label: {
            Text(name)
                .frame(maxWidth: .infinity)

        })
        .padding(.vertical, topPadding)
        .accentColor(acColor)
        .font(size)
        .fontWeight(.bold)
        .frame(maxWidth: .infinity)
        .background(bgColor)
        .cornerRadius(corner)
        .navigationDestination(isPresented: $isMovable) {
            destination
        }
    }
}

extension UINavigationController {
    // Remove back button text
    override open func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
