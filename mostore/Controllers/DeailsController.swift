//
//  DeailsController.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-16.
//

import Foundation

class DetailsController: ObservableObject {
    @Published var showAlert: Bool = false

    func addToCart(id: String) {
        /*  DataPost().addToCart(userId: storedId, productId: id, finish: finishPost)
         func finishPost(result: Bool) {
             self.showAlert = result
         }*/

        showAlert = true
    }
}
