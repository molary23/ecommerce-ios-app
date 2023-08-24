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

struct ExtTotalView: View {
    var heading: String
    var amount: Int
    var body: some View {
        HStack(content: {
            Text(heading)
                .font(.headline)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("$\(amount)")
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .trailing)
        })
        .frame(width: .infinity, height: .infinity, alignment: .leading)
    }
}


struct FloatingButton: View {
    let action: () -> Void
    let icon: String
    let fg: Color
    let bg: Color
    let label: String
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: action) {
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
