//
//  CartViewModel.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-03.
//

import SwiftUI

class  CartViewModel: ObservableObject {
    @Published var cartProduct: [Product] = []
    @Published var cartProductDic: [Product: Int] = [:]
    @Published var totalPrice: Double = 0
    
    func addToCart(addedProduct: Product){
        let products = cartProductDic.map({$0.key})
        if products.isEmpty {
            cartProductDic[addedProduct] = 1
            return
        }
        for product in products {
            if addedProduct.id == product.id {
                cartProductDic[product]! += 1
            } else {
                cartProductDic[addedProduct] = 1
            }
        }
    }
    func changeQuantity(product: Product,quantity: Int){
        cartProductDic[product] = quantity
    }
    func calculateTotalPrice(){
        var totalprice: Double = 0
        for (product,quantity) in cartProductDic {
            totalprice += product.price * Double(quantity)
        }
        totalPrice = totalprice
    }
    func removeFromCart(product: Product){
    }
}
