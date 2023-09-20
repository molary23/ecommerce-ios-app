//
//  RegisterController.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-16.
//

import Foundation

class RegisterController: ObservableObject {
    @Published var emailAddress: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var phone: String = ""
    @Published var username: String = ""
    @Published var navigate: Bool = false
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var status: String =  "warning"

    init() {}

    func registerUser() {
        guard validate(), validatePassword() else {
            return
        }
        registerRequest()
    }

    private func validate() -> Bool {
        errorMessage = ""
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty
            , !confirmPassword.trimmingCharacters(in: .whitespaces).isEmpty, !phone.trimmingCharacters(in: .whitespaces).isEmpty, !emailAddress.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errorMessage = "Please fill all fields"
            showAlert = true
            return false
        }
        return true
    }

    private func validatePassword() -> Bool {
        guard password == confirmPassword else {
            errorMessage = "Password Mismatched"
            showAlert = true
            return false
        }
        return true
    }

    func registerRequest() {
        isLoading = true
        let data: Data = "username=\(username)&password=\(password)&phone=\(phone)&email=\(emailAddress)".data(using: .utf8)!

        var request = URLRequest(url: URL(string: "\(API_URL)register")!)
        request.httpMethod = "POST"
        request.httpBody = data

        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField: "Accept-Language")

        URLSession.shared.dataTask(with: request) { body, response, _ in
            self.isLoading = false
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == 200 {
                let user = try! JSONDecoder().decode(UserModel.self, from: body!)
                
                DispatchQueue.main.async {
                    preferences.set(user.username, forKey: usernameKey)
                    preferences.set(user.email, forKey: emailKey)
                    preferences.set(user.id, forKey: idKey)
                    self.status = "success"
                    self.showAlert = true
                }
            }
        }.resume()
    }
}
