//
//  CartViewModel.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-03.
//

import SwiftUI

class  CartViewModel: ObservableObject {
    @Published var cartProduct: [Product] = []
    
    func addToCart(product: Product){
        cartProduct.append(product)
    }
    func removeFromCart(product: Product){
        for index in 0..<cartProduct.count{
            if product.id == cartProduct[index].id{
                cartProduct.remove(at: index)
            }
        }
    }
}
