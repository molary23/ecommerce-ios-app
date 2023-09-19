//
//  MainController.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-16.
//

import Foundation

class ProductController: ObservableObject {
    @Published var product =  ProductModel(id: "", name: "", description: "", price: 0.0, image: "", rating: 0.0, createdAt: "", updatedAt: "")//["id": "", "name": "", "image": "", "description": "", "price": 0.0, "rating": 0.0]
    @Published var recommendedDetails: Bool = false
    @Published var bestDetails: Bool = false
    @Published var dealDetails: Bool = false
    @Published var bestProducts = [ProductModel]()
    @Published var dealProducts = [ProductModel]()
    @Published var recommendedProducts = [ProductModel]()
    init() {
        loadProduct(page: 2, limit: 10, section: "deal")
        loadProduct(page: 0, limit: 10, section: "best")
        loadProduct(page: 1, limit: 5, section: "recommended")
    }

    func viewProductDetails(content: ProductModel, section: String) {
     /*   product["id"] = content.id
        product["name"] = content.name
        product["image"] = content.image
        product["description"] = content.description
        product["price"] = content.price
        product["rating"] = content.rating
*/
        product = content
        if section == "recommended" {
            recommendedDetails = true
        } else if section == "best" {
            bestDetails = true
        } else {
            dealDetails = true
        }
    }

    func loadProduct(page: Int, limit: Int, section: String) {
        getProduct(page: page, limit: limit) { products in
            if section == "best" {
                self.bestProducts = products
            } else if section == "recommended" {
                self.recommendedProducts = products
            } else if section == "deal" {
                self.dealProducts = products
            }
        }
    }

    func getProduct(page: Int, limit: Int, completion: @escaping ([ProductModel]) -> Void) {
        guard let url = URL(string: "http://localhost:8080/api/products?page=\(page)&limit=\(limit)") else {
            print("Invalid url...")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, _ in
            let httpResponse = response as? HTTPURLResponse
            if httpResponse!.statusCode == 200 {
                let productsObject = try! JSONDecoder().decode([ProductModel].self, from: data!)
                //  print(productsObject)
                DispatchQueue.main.async {
                    completion(productsObject)
                }
            }

        }.resume()
    }
}
