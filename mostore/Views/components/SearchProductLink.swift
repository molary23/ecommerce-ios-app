//
//  SearchProductLink.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-17.
//

import SwiftUI

struct SearchProductLink: View {
    let item: ProductModel
    let action: ()-> Void
    var body: some View {
        Button(action: { action() }, label: {
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

struct SearchProductLink_Previews: PreviewProvider {
    static var previews: some View {
        SearchProductLink(
            item: .init(id: "123", name: "name", description: "description", price: 0.0, image: "", rating: 0.0, createdAt: "\(Date())", updatedAt: "\(Date())"), action: {}
        )
    }
}
