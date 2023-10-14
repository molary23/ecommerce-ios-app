//
//  SearchController.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-17.
//

import Foundation

class SearchController: ObservableObject {
    @Published var searchedProducts = [ProductModel]()
    @Published var search: String = ""
    @Published var isSearchEmpty: Bool = false
    @Published var viewDetails: Bool = false
    @Published var product = ProductModel(id: "", name: "", description: "", price: 0.0, image: "", rating: 0.0, createdAt: "", updatedAt: "")

    init() {
    }

    func getSearchedProduct() {
        searchProduct(search: search) { products in
            if products.isEmpty {
                self.isSearchEmpty = true
            }
            self.searchedProducts = products
        }
    }

    func searchProduct(search: String, completion: @escaping ([ProductModel]) -> Void) {
        guard let url = URL(string: "\(API_URL)products/search?q=cha") else {
            print("Invalid url...")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, _ in
            let httpResponse = response as? HTTPURLResponse
            if httpResponse!.statusCode == 200 {
                let products = try! JSONDecoder().decode([ProductModel].self, from: data!)
                DispatchQueue.main.async {
                    completion(products)
                }
            }

        }.resume()
    }

}
