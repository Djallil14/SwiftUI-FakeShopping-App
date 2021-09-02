//
//  ShoppingItem.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-01.
//

import Foundation

struct Product: Identifiable, Codable {
    var id: Int
    var title: String
    var price: Double
    var description: String
    var category: String
    var image: String
    var rating: Rating
}
extension Product {
    var imageURL: URL {
        URL(string: image)!
    }
    var formatedRating: String {
        var result = ""
        for _ in 0...Int(rating.rate){
            result.append("⭐️")
        }
        
        return result
    }
}

struct Rating: Codable {
    let rate: Double
    let count: Int
}

extension Product {
    static var sampleProducts: [Product] {
        let response: [Product]? = try? Bundle.main.loadAndDecodeJSON(filename: "products")
        return response ?? [Product(id: 1, title: "noproduct", price: 10.5, description: "noproduct", category: "noproduct", image: "noproduct", rating: Rating(rate: 10.0, count: 5))]
    }
}
