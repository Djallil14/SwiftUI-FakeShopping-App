//
//  CartListView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct CartListView: View {
    @ObservedObject var cart: CartViewModel
    let products: [Product: Int]
    var body: some View {
        let productsDic = products.map({$0.key})
        List {
            ForEach(productsDic, id: \.self){key in
                CartListItem(cart: cart,product: key, quantity: products[key] ?? 0)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
}

struct CartList_Previews: PreviewProvider {
    static var previews: some View {
        CartListView(cart: CartViewModel(), products: [Product.sampleProducts[0]: 1])
    }
}
