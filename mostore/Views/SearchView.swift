//
//  SearchView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-05.
//

import SwiftUI

enum FocusedField {
    case search
}

struct SearchView: View {
    @EnvironmentObject var cartManager: CartManager

    @StateObject var searchController = SearchController()

    @FocusState private var focusedField: FocusedField?

    @State private var toSearch: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    HStack(spacing: 10, content: {
                        Image(systemName: "magnifyingglass")
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .font(.body)
                            .clipped()
                            .frame(maxWidth: 60)

                        TextField("\(PAGE_TEXT["input"]![7])", text: $searchController.search)
                            .accessibilityLabel(PAGE_TEXT["input"]![7])
                            .id("search_products")
                            .frame(maxWidth: .infinity, maxHeight: 60, alignment: .center)
                            .focused($focusedField, equals: .search)
                            .onSubmit {
                                searchController.getSearchedProduct()
                            }

                    })
                    .padding(.horizontal, 10)
                    Divider()
                        .frame(height: 1)
                        .padding(.horizontal, 30)
                        .background(Color.gray.opacity(0.6))
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 16)
                .frame(maxHeight: 50, alignment: .top)
                .onAppear {
                    focusedField = .search
                }

                if searchController.searchedProducts.isEmpty && searchController.isSearchEmpty {
                    NoItemsFound(text: PAGE_TEXT["text"]![17])
                }

                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 20, content: {
                        ForEach(searchController.searchedProducts) { item in
                            ProductSearchLink(item: item)
                        }
                    })
                }
                .padding(.horizontal, 8)
            }
            .navigationBarTitle(PAGE_TEXT["title"]![7], displayMode: .inline)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(CartManager())
    }
}
