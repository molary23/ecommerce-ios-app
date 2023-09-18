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
    var number: Int
    var street: String
    var city: String
    var zip: String
    var country: String
}

struct Card: Codable {
    var number: String?
    var month: String?
    var year: String?
    var cvv: String?
}

struct Book: Codable, Identifiable {
    var id = Int()
    var title: String
    var body: String
    var userId: Int
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

struct CartData: Codable, Identifiable {
    /*    static func == (lhs: CartData, rhs: CartData) -> Bool {
         lhs.product.id == rhs.product.id
     }

     func hash(into hasher: inout Hasher) {
         hasher.combine(product.id)
     }
     */
    var id = Int()
    var product: ProductJSON
    var quantity: Int
}
/*
class Api: ObservableObject {
    @Published var products = [ProductData]()

    func loadData(page: Int, limit: Int, completion: @escaping ([ProductData]) -> Void) {
        guard let url = URL(string: "http://localhost:8080/api/products?page=\(page)&limit=\(limit)") else {
            print("Invalid url...")
            return
        }

        URLSession.shared.dataTask(with: url) { [self] data, response, _ in
            let httpResponse = response as? HTTPURLResponse
            if httpResponse!.statusCode == 200 {
                let products = try! JSONDecoder().decode([ProductData].self, from: data!)
                DispatchQueue.main.async {
                    completion(products)
                }
            } else {
                completion(products)
            }

        }.resume()
    }
    
    
    func searchProduct(search: String, /*page: Int, limit: Int,*/ completion: @escaping ([ProductData]) -> Void) {
        guard let url = URL(string: "http://localhost:8080/api/products/product?search=\(search)") else {
            print("Invalid url...")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [self] data, response, _ in
            let httpResponse = response as? HTTPURLResponse
            if httpResponse!.statusCode == 200 {
                let products = try! JSONDecoder().decode([ProductData].self, from: data!)
                print(products)
                DispatchQueue.main.async {
                    completion(products)
                }
            } else {
                completion(products)
            }
            
        }.resume()
    }
    
}
*/
class CartApi: ObservableObject {
    @Published var cart = [CartData]()
    @Published var qty = Int()

    func loadCartData(userId: String, completion: @escaping ([CartData]) -> Void) {
        guard let url = URL(string: "http://localhost:8080/api/orders/user/products?userId=\(userId)") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, _ in

            let httpResponse = response as? HTTPURLResponse
            if httpResponse!.statusCode == 200 {
                let cart = try! JSONDecoder().decode([CartData].self, from: data!)
                DispatchQueue.main.async {
                    completion(cart)
                }
            } else {
                print(userId)
                completion([])
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

    func deleteAllOrder(userId: String) {
        let data: Data = "userId=\(userId)".data(using: .utf8)!

        var request = URLRequest(url: URL(string: "http://localhost:8080/api/orders/delete")!)
        request.httpMethod = "DELETE"
        request.httpBody = data

        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField: "Accept-Language")

        URLSession.shared.dataTask(with: request) { _, response, _ in
            let httpResponse = response as? HTTPURLResponse
            if httpResponse!.statusCode == 200 {
                print("deleted")
            }

        }.resume()
    }
}

class CheckApi: ObservableObject {
    @Published var total = Double()
    @Published var isPaid = Bool()
    @Published var isSaved = Bool()
    @Published var card = Card()

    func loadTotal(userId: String, completion: @escaping (Double) -> Void) {
        guard let url = URL(string: "http://localhost:8080/api/orders/total?userId=\(userId)") else {
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

    func makePayment(userId: String, amount: Double, lastFour: String, completion: @escaping (Bool) -> Void) {
        let data: Data = "userId=\(userId)&amount=\(amount)&lastFour=\(lastFour)".data(using: .utf8)!

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

    func saveCard(userId: String, number: String, month: String, year: String, cvv: String, completion: @escaping (Bool) -> Void) {
        let data: Data = "number=\(number)&month=\(month)&year=\(year)&cvv=\(cvv)".data(using: .utf8)!

        var request = URLRequest(url: URL(string: "http://localhost:8080/api/card?userId=\(userId)")!)
        request.httpMethod = "PUT"
        request.httpBody = data

        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField: "Accept-Language")

        URLSession.shared.dataTask(with: request) { body, response, _ in
            let httpResponse = response as? HTTPURLResponse
            if httpResponse!.statusCode == 200 {
                let isSaved = try! JSONDecoder().decode(Bool.self, from: body!)
                DispatchQueue.main.async {
                    completion(isSaved)
                }
            }
        }.resume()
    }

    func loadCard(userId: String, completion: @escaping (Card) -> Void) {
        guard let url = URL(string: "http://localhost:8080/api/user/card?userId=\(userId)") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { body, response, _ in
            let httpResponse = response as? HTTPURLResponse
            if httpResponse!.statusCode == 200 {
                let card = try! JSONDecoder().decode(Card.self, from: body!)
                preferences.set(card.number, forKey: storedNumber)
                preferences.set(card.month, forKey: storedMonth)
                preferences.set(card.year, forKey: storedYear)
                preferences.set(card.cvv, forKey: storedCVV)
                DispatchQueue.main.async {
                    completion(card)
                }
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

    func removeFromCart(userId: String, productId: String, finish: @escaping (Bool) -> Void) {
        let data: Data = "userId=\(userId)&productId=\(productId)".data(using: .utf8)!

        var request = URLRequest(url: URL(string: "http://localhost:8080/api/orders/remove")!)
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
