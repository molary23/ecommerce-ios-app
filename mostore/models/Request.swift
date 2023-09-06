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
struct Address {
    var id: String
    var number: Int
    var street: String
    var city: String
    var zip: String
    var country: String
}

struct Card {
    var id: String
    var number: String
    var month: String
    var year: String
    var cvv: String
}

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
    var createdAt: String?
    var updatedAt: String?
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

struct CartData: Codable, Hashable {
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
    @Published var qty = Int()

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

    func loadQuantity(orderId: String, productId: String, completion: @escaping (Int) -> Void) {
        guard let url = URL(string: "http://localhost:8080/api/orders/product/quantity?orderId=\(orderId)&productId=\(productId)") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let qty = try! JSONDecoder().decode(Int.self, from: data!)
            DispatchQueue.main.async {
                completion(qty)
            }
        }.resume()
    }
}

class CheckApi: ObservableObject {
    @Published var total = Double()
    @Published var isPaid = Bool()

    func loadTotal(orderId: String, completion: @escaping (Double) -> Void) {
        guard let url = URL(string: "http://localhost:8080/api/orders/total?orderId=\(orderId)") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let total = try! JSONDecoder().decode(Double.self, from: data!)
            DispatchQueue.main.async {
                completion(total)
            }
        }.resume()
    }

    func makePayment(userId: String, orderId: String, amount: Double, lastFour: String, completion: @escaping (Bool) -> Void) {
        let data: Data = "userId=\(userId)&orderId=\(orderId)&amount=\(amount)&lastFour=\(lastFour)".data(using: .utf8)!

        var request = URLRequest(url: URL(string: "http://localhost:8080/api/pay")!)
        request.httpMethod = "POST"
        request.httpBody = data

        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField: "Accept-Language")

        URLSession.shared.dataTask(with: request) { body, _, _ in
            let isPaid = try! JSONDecoder().decode(Bool.self, from: body!)
            DispatchQueue.main.async {
                completion(isPaid)
            }

        }.resume()
    }
}

class DataPost: ObservableObject {
    func addToCart(userId: String, productId: String, finish: @escaping (Bool) -> Void) {
        let data: Data = "userId=\(userId)&productId=\(productId)".data(using: .utf8)!

        var request = URLRequest(url: URL(string: "http://localhost:8080/api/orders/add")!)
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
}

struct UserRequestData: Codable, Identifiable {
    var id: String
    var username: String
    var email: String
}

class UserApi: ObservableObject {
    func loginRequest(username: String, password: String, completion: @escaping (Any) -> Void) {
        let data: Data = "username=\(username)&password=\(password)".data(using: .utf8)!

        var request = URLRequest(url: URL(string: "http://localhost:8080/api/auth")!)
        request.httpMethod = "POST"
        request.httpBody = data

        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField: "Accept-Language")

        URLSession.shared.dataTask(with: request) { body, response, _ in
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == 200 {
                let userRequest = try! JSONDecoder().decode(UserRequestData.self, from: body!)
                preferences.set(userRequest.username, forKey: usernameKey)
                preferences.set(userRequest.email, forKey: emailKey)
                DispatchQueue.main.async {
                    completion(true)
                }
            } else {
                print("Failed request!")
                DispatchQueue.main.async {
                    completion(false)
                }
            }

        }.resume()
    }
}
