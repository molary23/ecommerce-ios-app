//
//  CartManager.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-18.
//

import Foundation

class CartManager: ObservableObject {
    @Published private(set) var products: [ProductModel] = []
    @Published private(set) var singleProductOccurence: [ProductModel] = []

    init() {
        getCartItems()
    }

    func getCartItems() {
        loadCartData(userId: storedId) { items in
            for item in items {
                var x = 0
                self.singleProductOccurence.append(item.product)
                repeat {
                    self.products.append(item.product)
                    x += 1
                } while item.quantity > x
            }
        }
    }

    func addToCart(product: ProductModel) {
        products.append(product)
        if !singleProductOccurence.contains(where: { $0.id == product.id }) {
            singleProductOccurence.append(product)
        }
    }

    func removeFromCart(product: ProductModel) {
        guard let productIndex = products.firstIndex(where: ({ $0.id == product.id })) else { return }
        products.remove(at: productIndex)
        if !products.contains(where: { $0.id == product.id }) {
            singleProductOccurence = singleProductOccurence.filter({ $0.id != product.id })
        }
    }

    func removeProductFromCart(product: ProductModel) {
        products = products.filter({ $0.id != product.id })
        singleProductOccurence = singleProductOccurence.filter({ $0.id != product.id })
    }

    func removeAllFromCart() {
        products.removeAll()
        singleProductOccurence.removeAll()
    }

    func loadCartData(userId: String, completion: @escaping ([CartModel]) -> Void) {
        guard let url = URL(string: "\(API_URL)orders/user/products?userId=\(userId)") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, _ in

            let httpResponse = response as? HTTPURLResponse
            if httpResponse!.statusCode == 200 {
                let cart = try! JSONDecoder().decode([CartModel].self, from: data!)
                DispatchQueue.main.async {
                    completion(cart)
                }
            } else {
                completion([])
            }

        }.resume()
    }
}
