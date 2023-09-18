//
//  ProductModel.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-17.
//

import Foundation

struct ProductModel: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    let price: Double
    let image: String
    let rating: Double
    let createdAt: String?
    let updatedAt: String?
}
