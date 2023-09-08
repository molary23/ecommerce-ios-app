//
//  SearchView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-05.
//

import SwiftUI

struct SearchView: View {
    @State var products = [ProductData]()
    @State private var search: String = ""
    @State private var isSearchEmpty: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                TextField("\(PAGE_TEXT["input"]![7])", text: $search)
                    .accessibilityLabel(PAGE_TEXT["input"]![7])
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .id("search_products")
                    .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                    .background(Color("off-white"))
                    .onSubmit {
                        Api().searchProduct(search: search) { products in
                            if products.isEmpty {
                                isSearchEmpty = true
                            }
                            self.products = products
                        }
                    }
            }
            .padding(.vertical, 6)
            .frame(maxHeight: 50, alignment: .top)

            if products.isEmpty && isSearchEmpty {
                NotFoundLayout(text: PAGE_TEXT["text"]![17])
            }

            ScrollView(showsIndicators: false) {
                ForEach(products) { item in
                    HStack(spacing: 8, content: {
                        ExtAsyncImage(imageURL: item.image.components(separatedBy: "|")[0], size: 100, shape: RoundedRectangle(cornerRadius: 8))
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
                }
            }
            .padding(.horizontal, 8)

            .navigationBarTitle(PAGE_TEXT["title"]![7], displayMode: .inline)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
