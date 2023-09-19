//
//  DeailsController.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-16.
//

import Foundation

class DetailsController: ObservableObject {
    @Published var showAlert: Bool = false

    func addToCart(id: String) {
        addProductToCart(productId: id, finish: finishPost)
        func finishPost(result: Bool) {
            showAlert = result
        }
    }

    func addProductToCart(productId: String, finish: @escaping (Bool) -> Void) {
        let data: Data = "userId=\(storedId)&productId=\(productId)".data(using: .utf8)!

        var request = URLRequest(url: URL(string: "http://localhost:8080/api/orders/add")!)
        request.httpMethod = "POST"
        request.httpBody = data

        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField: "Accept-Language")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { _, response, _ in
            let httpResponse = response as? HTTPURLResponse
            if httpResponse!.statusCode == 200 {
                DispatchQueue.main.async {
                    finish(true)
                }
            } else {
                DispatchQueue.main.async {
                    finish(false)
                }
            }

        })

        task.resume()
    }
}
