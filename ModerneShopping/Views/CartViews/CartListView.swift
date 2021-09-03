//
//  CartListView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct CartListView: View {
    let products: [Product]
    var body: some View {
        List {
            ForEach(products){product in
                CartListItem(product: product)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
}

struct CartList_Previews: PreviewProvider {
    static var previews: some View {
        CartListView(products: Product.sampleProducts)
    }
}
