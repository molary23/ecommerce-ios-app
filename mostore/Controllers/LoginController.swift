//
//  LoginController.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-16.
//

import Foundation

class LoginController: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published var isSignedIn: Bool = false

    init() {}

    private func validate() -> Bool {
        errorMessage = ""
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty, !username.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill all fields"
            showAlert = true
            return false
        }
        return true
    }

    func login() {
        guard validate() else {
            return
        }
        loginRequest()
    }

    func loginRequest() {
        let data: Data = "username=\(username)&password=\(password)".data(using: .utf8)!

        var request = URLRequest(url: URL(string: "http://localhost:8080/api/auth")!)
        request.httpMethod = "POST"
        request.httpBody = data

        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField: "Accept-Language")

        URLSession.shared.dataTask(with: request) { body, response, _ in
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == 200 {
                let user = try! JSONDecoder().decode(UserModel.self, from: body!)
                DispatchQueue.main.async {
                    preferences.set(user.username, forKey: usernameKey)
                    preferences.set(user.email, forKey: emailKey)
                    preferences.set(user.id, forKey: idKey)
                    self.isSignedIn = true
                }
            }
        }.resume()
    }
}
