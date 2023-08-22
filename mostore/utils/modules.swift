//
//  modules.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-21.
//

import Foundation
import SwiftUI

let STRING_TUPLE = (
    "Email Address",
    "Password",
    "Login",
    "Register",
    "Phone Number",
    "Username",
    "All fields are compulsory",
    "Place Order",
    "Mo Store",
    "Continue Shopping",
    "Order Confirmation",
    "Thank you for your purchase.",
    "Your order will be shipped in 2-5 days. Tracking info will be sent to you asap.",
    "PAYMENT",
    "Card Number",
    "Expiration",
    "Secure Code",
    "MM/YY",
    "CVV",
    "Subtotal",
    "Tax",
    "Total" // 21
)

struct LabelAlignment: UIViewRepresentable {
    var text: String
    var textAlignmentStyle: TextAlignmentStyle
    var width: CGFloat
    var size: CGFloat

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.font = label.font.withSize(size)
        label.textAlignment = NSTextAlignment(rawValue: textAlignmentStyle.rawValue)!
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = width
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .vertical)

        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.text = text
    }
}

enum TextAlignmentStyle: Int {
    case left = 0, center = 1, right = 2, justified = 3, natural = 4
}
