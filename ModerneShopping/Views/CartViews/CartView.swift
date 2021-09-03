//
//  CartView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct CartView: View {
    var products: [Product]
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            VStack{
                CartListView(products: products)
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(products: Product.sampleProducts)
    }
}
