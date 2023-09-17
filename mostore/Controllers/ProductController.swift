//
//  MainController.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-16.
//

import Foundation

class ProductController: ObservableObject {
    @Published var product: [String: Any] = ["id": "", "name": "", "image": "", "description": "", "price": 0.0, "rating": 0.0]
    @Published var recommendedDetails: Bool = false
    @Published var bestDetails: Bool = false
    @Published var dealDetails: Bool = false
    init() {}

    func viewProductDetails(content: ProductData, section: String) {
        product["id"] = content.id
        product["name"] = content.name
        product["image"] = content.image
        product["description"] = content.description
        product["price"] = content.price
        product["rating"] = content.rating

        if section == "recommended" {
            recommendedDetails = true
        } else if section == "best" {
            bestDetails = true
        } else {
            dealDetails = true
        }
       
    }
}
