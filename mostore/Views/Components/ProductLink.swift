//
//  ProductLink.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-16.
//

import SwiftUI

struct ProductLink: View {
    let name: String
    let price: Double
    let image: String
    let size: CGFloat
    let shape: any Shape
    let action: () -> Void

    var body: some View {
        Button(action: { action() }, label: {
            VStack {
                DataImage(imageURL: image.components(separatedBy: "|")[0], size: size, shape: shape)

                Text("\(name)")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)

                Text("$\(price, specifier: "%.2f")")
                    .font(.body)
                    .fontWeight(.bold)
            }
            .frame(width: size)
        })
    }
}

struct ProductLink_Previews: PreviewProvider {
    static var previews: some View {
        ProductLink(
            name: "Product Name",
            price: 0.0,
            image: "",
            size: 100,
            shape: Circle()
        ) {}
    }
}
