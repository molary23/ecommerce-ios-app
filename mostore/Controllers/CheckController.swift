//
//  CheckController.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-18.
//

import Foundation

class CheckController: ObservableObject {
    @Published var month: String = ""
    @Published var year: String = ""
    @Published var cvv: String = ""
    @Published var cardNumber: String = ""
    @Published var response: Any = false
    @Published var total: Double = 0
    @Published var tax: Double = 0
    @Published var amount: Double = 0
    @Published var savePayment: Bool = false
    @Published var isSheetActive: Bool = false
    @Published var alreadySaved: Bool = false
    @Published var isPaid: Bool = false
    @Published var isFailed: Bool = false
    @Published var card: Card = Card()

    @Published var isSaved = Bool()

    init() {
    }

    func getAmount() {
        loadTotal { amount in
            self.amount = amount
            self.tax = (amount * 13) / 100
            self.total = self.amount + self.tax
        }
    }

    func setCard() {
        saveCard { status in
            self.isSaved = status
        }
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

    func saveCard(completion: @escaping (Bool) -> Void) {
        let data: Data = "number=\(cardNumber)&month=\(month)&year=\(year)&cvv=\(cvv)".data(using: .utf8)!

        var request = URLRequest(url: URL(string: "http://localhost:8080/api/card?userId=\(storedId)")!)
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

    func loadTotal(completion: @escaping (Double) -> Void) {
        guard let url = URL(string: "http://localhost:8080/api/orders/total?userId=\(storedId)") else {
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
}
