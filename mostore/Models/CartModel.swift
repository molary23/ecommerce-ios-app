//
//  CartModel.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-18.
//

import Foundation

struct CartModel: Codable, Identifiable {
    /*    static func == (lhs: CartData, rhs: CartData) -> Bool {
     lhs.product.id == rhs.product.id
     }
     
     func hash(into hasher: inout Hasher) {
     hasher.combine(product.id)
     }
     */
    var id = Int()
    var product: ProductModel
    var quantity: Int
    
    mutating func updateQuantity(_ option: String){
        if(option == "minus"){
            quantity -= 1
        }else if(option == "plus"){
            quantity += 1
        }
    }
}
