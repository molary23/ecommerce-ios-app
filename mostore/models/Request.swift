//
//  User.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-27.
//

import Foundation

/*
 struct UserData: Codable, Identifiable {
     let id = UUID()
     var email: String
     var username: String
     var card: String
 }*/

struct Book: Codable, Identifiable {
    var id = Int()
    var title: String
    var body: String
    var userId: Int
}

struct ProductData: Codable, Identifiable {
    var id = String()
    var name: String
    var description: String
    var price: Double
    var image: String
    var rating: Double
    var createdAt: String
    var updatedAt: String
}


struct ProductJSON: Codable {
    var id: String
    var name: String
    var description: String
    var price: Double
    var image: String
    var rating: Double
    var createdAt: String?
    var updatedAt: String?
}

struct CartData:  Codable, Hashable{
    static func == (lhs: CartData, rhs: CartData) -> Bool {
        lhs.product.id == rhs.product.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(product.id)
    }
    
    var product: ProductJSON
    var quantity: Int
}






class Api: ObservableObject {
    @Published var products = [ProductData]()

    func loadData(page: Int, limit: Int, completion: @escaping ([ProductData]) -> Void) {
        guard let url = URL(string: "http://localhost:8080/api/products?page=\(page)&limit=\(limit)") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let products = try! JSONDecoder().decode([ProductData].self, from: data!)
            DispatchQueue.main.async {
                completion(products)
            }
        }.resume()
    }
}


class CartApi: ObservableObject {
    @Published var cart = [CartData]()
    
    func loadData(orderId: String, completion: @escaping ([CartData]) -> Void) {
        guard let url = URL(string: "http://localhost:8080/api/orders/products?orderId=\(orderId)") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let cart = try! JSONDecoder().decode([CartData].self, from: data!)
           DispatchQueue.main.async {
                completion(cart)
            }
        }.resume()
    }
}


class DataPost: ObservableObject {
    func postRequest(userId: String, productId: String, finish: @escaping (Int) -> Void) {
        //   let parameters: [String: Any] = ["userId": "64ed3a3efc29f826a41df4c2", "productId": "64ed53ecf34e3ac82344a30e"] as Dictionary<String, Any>

        let data: Data = "userId=\(userId)&productId=\(productId)".data(using: .utf8)!

        var request = URLRequest(url: URL(string: "http://localhost:8080/api/orders/add")!)
        request.httpMethod = "POST"
        request.httpBody = data
        //   request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //  request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //  request.setValue("application/json", forHTTPHeaderField: "Accept")

        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField: "Accept-Language")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { _, response, _ in
            let httpResponse = response as? HTTPURLResponse
            finish(httpResponse!.statusCode)

        })

        task.resume()
    }
    
}
