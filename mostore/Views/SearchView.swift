//
//  SearchView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-05.
//

import SwiftUI

struct SearchView: View {
    @StateObject var searchController = SearchController()
    var body: some View {
        NavigationStack {
            VStack {
                TextField("\(PAGE_TEXT["input"]![7])", text: $searchController.search)
                    .accessibilityLabel(PAGE_TEXT["input"]![7])
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .id("search_products")
                    .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                    .background(Color("off-white"))
                    .onSubmit {
                        searchController.getSearchedProduct()
                    }
            }
            .padding(.vertical, 6)
            .frame(maxHeight: 50, alignment: .top)

            if searchController.searchedProducts.isEmpty && searchController.isSearchEmpty {
                NoItemsFound(text: PAGE_TEXT["text"]![17])
            }

            ScrollView(showsIndicators: false) {
                ForEach(searchController.searchedProducts) { item in
                    SearchProductLink(item: item, action: { searchController.viewProductDetails(content: item) })
                        .navigationDestination(isPresented: $searchController.viewDetails) {
                            DetailsView(productDetails: searchController.product)
                        }
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
