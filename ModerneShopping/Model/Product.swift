//
//  ShoppingItem.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-01.
//

import Foundation

struct Product: Identifiable, Codable, Hashable {
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
            result.append("★")
        }
        while result.count<5{
            result += "☆"
        }
        return result
    }
}

struct Rating: Codable, Hashable {
    let rate: Double
    // to remplace with let count when the api bug is fixed https://github.com/keikaavousi/fake-store-api/issues/31
    // let count: Int
    let manualCount: Int = Int.random(in: 0...500)
}

extension Product {
    static var sampleProducts: [Product] {
        let response: [Product]? = try? Bundle.main.loadAndDecodeJSON(filename: "products")
        return response ?? [Product(id: 1, title: "noproduct", price: 10.5, description: "noproduct", category: "noproduct", image: "noproduct", rating: Rating(rate: 10.0))]
    }
}
