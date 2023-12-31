//
//  HomeController.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-16.
//

import Foundation

class HomeController: ObservableObject {
    @Published var currentUserId: String = ""

    init() {
        currentUserId = preferences.string(forKey: idKey) ?? ""
    }

}
