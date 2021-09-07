//
//  ProductList.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct ProductList: View {
    @EnvironmentObject var cart: CartViewModel
    let products: [Product]
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        LazyVGrid(columns: columns){
            ForEach(products){product in
                NavigationLink(destination:ProductView(product: product).environmentObject(cart)){
                    ProductListItem(product: product)
                }.accentColor(.primary)
            }
        }
    }
}

struct ProductList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView  {
            ProductList(products: Product.sampleProducts).environmentObject(CartViewModel())
        }
    }
}

