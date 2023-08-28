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
