//
//  Product.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-26.
//

import Foundation

class Product: ObservableObject {
    @Published var product: [String: Any] = ["id": "", "name": "", "image": "", "description": "", "price": 0, "rating": 0]
}

class User: ObservableObject {
    @Published var name = ""
    @Published var username = ""
    @Published var email = ""
    @Published var savedCard = ""
}

class Cart: ObservableObject {
    @Published var cart: [Product] = []
}

/*
 class NavigationModelView: ObservableObject {
     @Published var currentView = DifferentViews.LoginView

     func onViewChange(newView: DifferentViews) {
         currentView = newView
     }
 }

 enum DifferentViews {
     case LoginView
     case MainView
     case CartView
     case CheckoutView
     case DetailsView
     case SettingsView
     case ConfirmationView
 }

 */
