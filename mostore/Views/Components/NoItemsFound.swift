//
//  NoItemsFound.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-15.
//

import SwiftUI

struct NoItemsFound: View {
    let text: String
    var body: some View {
        VStack {
            Text(text)
                .multilineTextAlignment(.center)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity)
        }
    }
}

struct NoItemsFound_Previews: PreviewProvider {
    static var previews: some View {
        NoItemsFound(text: "No Items Found")
    }
}
