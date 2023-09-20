//
//  TextField.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-19.
//

import SwiftUI

struct TextFieldView: View {
    let placeholder: String
    let placement: TextAlignment
    let id: String
    @Binding var value: String

    var body: some View {
        TextField(placeholder, text: $value)
            .accessibilityLabel(placeholder)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .multilineTextAlignment(placement)
            .id(id)
         //   .textFieldStyle(.roundedBorder)
        .autocapitalization(.none)
        .autocorrectionDisabled()
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(placeholder: "Textfield", placement: .leading, id: "textField", value: Binding(get: { "" }, set: { _ in }))
    }
}
