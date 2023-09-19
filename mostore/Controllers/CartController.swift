//
//  CartController.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-18.
//

import Foundation

class CartController: ObservableObject {
    @Published var cart : [CartModel] = []
    @Published var isAgree: Bool = true
    
    
    @Published var carts: [CartData] = []
    @Published var isCartEmpty: Bool = true
    @Published  var quantity: String = ""
  //  @Published  var hasCartUpdate: Bool = true
  //  @Published  var gotoCheckout: Bool = true
    @Published var showAlert: Bool = true
    init() {
       // getCartItems()
    }

   
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
    }

    
    func deleteAllOrder() {
        let data: Data = "userId=\(storedId)".data(using: .utf8)!
        
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
