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
let idKey = "userId"
let numberKey = "cardNumber"
let monthKey = "cardMonth"
let yearKey = "cardYear"
let cvvKey = "cardCVV"
var storedUsername = preferences.string(forKey: usernameKey) ?? ""
var storedEmail = preferences.string(forKey: emailKey) ?? ""
var storedId = preferences.string(forKey: idKey) ?? "64f17793033bd22637553a57"
var storedNumber = preferences.string(forKey: numberKey) ?? ""
var storedMonth = preferences.string(forKey: monthKey) ?? ""
var storedYear = preferences.string(forKey: yearKey) ?? ""
var storedCVV = preferences.string(forKey: cvvKey) ?? ""


