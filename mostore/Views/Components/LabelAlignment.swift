//
//  TextAlignment.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-15.
//

import SwiftUI

enum TextAlignmentStyle: Int {
    case left = 0, center = 1, right = 2, justified = 3, natural = 4
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

struct LabelAlignment_Previews: PreviewProvider {
    static var previews: some View {
        LabelAlignment(
            text: "Hello World! This is a new play. Thank you for trying to check this component", textAlignmentStyle: .justified, width: UIScreen.main.bounds.width - 20, size: 20.0
        )
    }
}
