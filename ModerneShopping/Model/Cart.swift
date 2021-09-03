//
//  Cart.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-03.
//

import Foundation

struct Cart: Identifiable, Codable {
    var id: Int
    var userId: Int
    var date: String
    var products: [CartProduct]
    var __v: Int
}

struct CartProduct: Codable {
    var productId: Int
    var quantity: Int
}

extension Cart {
    static var sampleCartProducts: Cart {
        let response: Cart? = try? Bundle.main.loadAndDecodeJSON(filename: "cart5")
        return response ?? Cart(id: 1, userId: 2, date: "2012/02/02", products: [CartProduct(productId: 2, quantity: 1)], __v: 0)
    }
}
