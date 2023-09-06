//
//  mostoreApp.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-19.
//

import SwiftUI

@main
struct mostoreApp: App {
    @StateObject private var product = Product()
    var body: some Scene {
        WindowGroup {
            if storedEmail.isEmpty {
                LoginView()
            } else {
                MainView()
            }
                
        }
    }
}
