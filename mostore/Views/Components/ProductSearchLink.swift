//
//  ProductSearchLink.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-10-13.
//

import SwiftUI

struct ProductSearchLink: View {
    let item: ProductModel
    var body: some View {
        NavigationLink(destination: DetailsView(productDetails: item), label: {
            HStack(spacing: 8, content: {
                DataImage(imageURL: item.image.components(separatedBy: "|")[0], size: 100, shape: RoundedRectangle(cornerRadius: 8))
                VStack {
                    HStack(spacing: 8, content: {
                        Text("\(item.name)")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                        
                    })
                    
                    HStack {
                        Text("$\(item.price, specifier: "%.2f")")
                            .font(.body)
                            .fontWeight(.bold)
                            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                    }.frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .leading)
                }
                
                .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
                .padding()
            })
            .padding()
            .background(Color("off-white"))
            .cornerRadius(8)
        })
    }
}

#Preview {
    ProductSearchLink(
        item: .init(id: "123", name: "name", description: "description", price: 0.0, image: "", rating: 0.0, createdAt: "\(Date())", updatedAt: "\(Date())")
    )
}
