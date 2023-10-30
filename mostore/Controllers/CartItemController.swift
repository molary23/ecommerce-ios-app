//
//  CartItemController.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-18.
//

import Foundation

class CartItemController: ObservableObject {
    // @Published var cartItem: CartModel
    let storedId = preferences.string(forKey: idKey) ?? ""
    init() {
    }

    func addQty(productId: String) {
        addToCart(productId: productId) { _ in
        }
    }

    func removeQty(productId: String) {
        removeFromCart(productId: productId) { _ in
        }
    }

    func addToCart(productId: String, finish: @escaping (Bool) -> Void) {
        let data: Data = "userId=\(storedId)&productId=\(productId)".data(using: .utf8)!

        var request = URLRequest(url: URL(string: "\(API_URL)orders/add")!)
        request.httpMethod = "POST"
        request.httpBody = data

        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField: "Accept-Language")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { _, response, _ in
            let httpResponse = response as? HTTPURLResponse
            if httpResponse!.statusCode == 200 {
                finish(true)
            } else {
                finish(false)
            }

        })

        task.resume()
    }

    func removeFromCart(productId: String, finish: @escaping (Bool) -> Void) {
        let data: Data = "userId=\(storedId)&productId=\(productId)".data(using: .utf8)!

        var request = URLRequest(url: URL(string: "\(API_URL)orders/remove")!)
        request.httpMethod = "DELETE"
        request.httpBody = data

        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField: "Accept-Language")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { _, response, _ in
            let httpResponse = response as? HTTPURLResponse
            if httpResponse!.statusCode == 200 {
                finish(true)
            } else {
                finish(false)
            }

        })

        task.resume()
    }
    
    
    
}
