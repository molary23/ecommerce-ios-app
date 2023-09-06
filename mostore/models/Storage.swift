//
//  Storage.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-26.
//

import Foundation

let preferences = UserDefaults.standard

let usernameKey = "username"
let emailKey = "email"
var storedUsername = preferences.string(forKey: usernameKey) ?? ""
var storedEmail = preferences.string(forKey: emailKey) ?? ""


