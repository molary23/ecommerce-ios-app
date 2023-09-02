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
}

struct CartData: Codable, Identifiable {
    var id = String()
    var name: String
    var price: Double
    var image: String
    var rating: Double
}

/*
 func postRequest() {
     // declare the parameter as a dictionary that contains string as key and value combination. considering inputs are valid

     let parameters: [String: Any] = ["title": "foo",
                                      "body": "bar",
                                      "userId": 1]

     // create the url with URL
     let url = URL(string: "https://jsonplaceholder.typicode.com/posts")! // change server url accordingly

     // create the session object
     let session = URLSession.shared

     // now create the URLRequest object using the url object
     var request = URLRequest(url: url)
     request.httpMethod = "POST" // set http method as POST

     // add headers for the request
     request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
     request.addValue("application/json", forHTTPHeaderField: "Accept")

     do {
         // convert parameters to Data and assign dictionary to httpBody of request
         request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
     } catch let error {
         print(error.localizedDescription)
         return
     }

     // create dataTask using the session object to send data to the server
     let task = session.dataTask(with: request) { data, response, error in

         if let error = error {
             print("Post Request Error: \(error.localizedDescription)")
             return
         }

         // ensure there is valid response code returned from this HTTP response
         guard let httpResponse = response as? HTTPURLResponse,
               (200 ... 299).contains(httpResponse.statusCode)
         else {
             print("Invalid Response received from the server")
             return
         }

         // ensure there is data returned
         guard let responseData = data else {
             print("nil Data received from the server")
             return
         }

         do {
             // create json object from data or use JSONDecoder to convert to Model stuct
             if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
                 print(jsonResponse)
                 // handle json response
             } else {
                 print("data maybe corrupted or in wrong format")
                 throw URLError(.badServerResponse)
             }
         } catch let error {
             print(error.localizedDescription)
         }
     }
     // perform the task
     task.resume()
 }
 */

/*
 func getRequest(page:Int,  limit:Int) {
     // declare the parameter as a dictionary that contains string as key and value combination. considering inputs are valid

     // create the url with URL
     //
     let url = URL(string: "https://jsonplaceholder.typicode.com/posts")! // change server url accordingly

     // create the session object
     let session = URLSession.shared

     // now create the URLRequest object using the url object
     var request = URLRequest(url: url)
     request.httpMethod = "GET" // set http method as POST

     // add headers for the request
     request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
     request.addValue("application/json", forHTTPHeaderField: "Accept")

     // create dataTask using the session object to send data to the server
     let task = session.dataTask(with: request) { data, response, error in

         if let error = error {
             print("GET Request Error: \(error.localizedDescription)")
             return
         }

         // ensure there is valid response code returned from this HTTP response
         guard let httpResponse = response as? HTTPURLResponse,
               (200 ... 299).contains(httpResponse.statusCode)
         else {
             print("Invalid Response received from the server")
             return
         }

         // ensure there is data returned
         guard let responseData = data else {
             print("nil Data received from the server")
             return
         }

         let serverResponse = try! JSONDecoder().decode([ProductData].self, from: responseData)
                 print(serverResponse)

     }
     // perform the task
     task.resume()

 }

  class Api: ObservableObject {
  @Published var books = [Book]()

  func loadData(completion: @escaping ([Book]) -> Void) {
  guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
  print("Invalid url...")
  return
  }
  URLSession.shared.dataTask(with: url) { data, _, _ in
  let books = try! JSONDecoder().decode([Book].self, from: data!)
  print(books)
  DispatchQueue.main.async {
  completion(books)
  }
  }.resume()
  }
  }

 */

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

/*
 func postRequest(userId: String, productId: String) {
     // declare the parameter as a dictionary that contains string as key and value combination. considering inputs are valid

     let parameters: [String: Any] = ["data": [
         "userId": userId,
         "productId": productId],
     ]

     // create the url with URL
     let url = URL(string: "http://localhost:8080/api/orders/add")! // change server url accordingly

     // create the session object
     let session = URLSession.shared

     // now create the URLRequest object using the url object
     var request = URLRequest(url: url)
     request.httpMethod = "POST" // set http method as POST

     // add headers for the request
     request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
     request.addValue("application/json", forHTTPHeaderField: "Accept")

     do {
         // convert parameters to Data and assign dictionary to httpBody of request
         request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
     } catch let error {
         print(error.localizedDescription)
         return
     }

     // create dataTask using the session object to send data to the server
     let task = session.dataTask(with: request) { data, response, error in

         if let error = error {
             print("Post Request Error: \(error.localizedDescription)")
             return
         }

         // ensure there is valid response code returned from this HTTP response
         guard let httpResponse = response as? HTTPURLResponse,
               (200 ... 299).contains(httpResponse.statusCode)
         else {
             //  let httpResponse = response as? HTTPURLResponse
             //  print(httpResponse ?? "here")
             print("Invalid Response received from the server")
             return
         }

         // ensure there is data returned
         guard let responseData = data else {
             print("nil Data received from the server")
             return
         }

         do {
             // create json object from data or use JSONDecoder to convert to Model stuct
             if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
                 print(jsonResponse)
                 // handle json response
             } else {
                 print("data maybe corrupted or in wrong format")
                 throw URLError(.badServerResponse)
             }
         } catch let error {
             print(error.localizedDescription)
         }
     }
     // perform the task
     task.resume()
 }

 class HttpAuth: ObservableObject {

     @Published var authenticated = false

     func postAuth(username: String, password: String) {
         guard let url = URL(string: "http://mysite/loginswift.php") else { return }

         let body: [String: String] = ["username": username, "password": password]

         let finalBody = try! JSONSerialization.data(withJSONObject: body)

         var request = URLRequest(url: url)
         request.httpMethod = "POST"
         request.httpBody = finalBody
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")

         URLSession.shared.dataTask(with: request) { (data, response, error) in
             guard let data = data else { return }
             let resData = try! JSONDecoder().decode(ServerMessage.self, from: data)
             print(resData.res)
             if resData.res == "correct" {
                 DispatchQueue.main.async {
                     self.authenticated = true
                 }
             }
         }.resume()
     }
 }

  */

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



/*

 */
