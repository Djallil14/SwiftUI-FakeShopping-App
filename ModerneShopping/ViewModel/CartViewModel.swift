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
    @Published var showShowcaseSheet: Bool = false
    
    func addToCart(addedProduct: Product, quantity: Int){
        let products = cartProductDic.map({$0.key})
        if products.isEmpty {
            withAnimation{
            cartProductDic[addedProduct] = quantity
            }
            return
        }
        for product in products {
            if addedProduct.id == product.id {
                withAnimation{
                cartProductDic[product]! += 1
                }
            } else {
                if !products.contains(where: {$0.id == addedProduct.id}){
                    withAnimation{
                    cartProductDic[addedProduct] = quantity
                    }
                }
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
        withAnimation{
        totalPrice = totalprice
        }
    }
    func removeFromCart(toRemove: Product){
        cartProductDic.removeValue(forKey: toRemove)
    }
}
