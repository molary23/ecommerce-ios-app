//
//  ProductLink.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-16.
//

import SwiftUI

struct ProductLink: View {
    let item: ProductModel
    let size: CGFloat
    let shape: any Shape


    var body: some View {
        NavigationLink(destination: DetailsView(productDetails: item), label: {
            VStack {
                DataImage(imageURL: item.image.components(separatedBy: "|")[0], size: size, shape: shape)

                Text("\(item.name)")
                    .font(.system(size: 14))
                    .fontWeight(.semibold)

                Text("$\(item.price, specifier: "%.2f")")
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
            item: .init(id: "123", name: "name", description: "description", price: 0.0, image: "", rating: 0.0, createdAt: "\(Date())", updatedAt: "\(Date())"),
            size: 100,
            shape: Circle()
        )
    }
}
