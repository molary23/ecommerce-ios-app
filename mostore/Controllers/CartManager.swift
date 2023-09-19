//
//  CartManager.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-18.
//

import Foundation

class CartManager: ObservableObject {
    @Published private(set) var products: [ProductModel] = []
    @Published private(set) var quantity: Int = 1
    //  @Published var cart : [CartModel] = []

    init() {
    }

    func addToCart(product: ProductModel) {
        products.append(product)
    }

    func removeFromCart(product: ProductModel) {
        guard var productIndex = products.firstIndex(where: ({ $0.id != product.id })) else { return }
        products.remove(at: productIndex)
    }

    func removeAllFromCart() {
        products.removeAll()
    }

    /*
     func getCartItems() {
         loadCartData(userId: storedId) { carts in
             self.cart = carts
         }

     }

     func loadCartData(userId: String, completion: @escaping ([CartModel]) -> Void) {
         guard let url = URL(string: "http://localhost:8080/api/orders/user/products?userId=\(userId)") else {
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
     }*/
}
