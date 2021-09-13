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
    @Binding var showDelete: Bool
    var body: some View {
        let productsDic = products.map({$0.key})
        List {
            ForEach(productsDic, id: \.self){key in
                ZStack {
                    Button(action: {
                        withAnimation{
                            cart.removeFromCart(toRemove: key)
                        }
                    }){
                        HStack {
                            VStack {
                                Spacer()
                                Image(systemName: "xmark")
                                    .imageScale(.large)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .frame(width: 100)
                            .background(Color.red)
                            .frame(width: 100)
                            Spacer()
                        }
                    }.disabled(!showDelete)
                    CartListItem(cart: cart,product: key, quantity: products[key] ?? 0)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .offset(x:showDelete ? 100 : 0)
                }.listRowBackground(Color.background)
            }
        }
    }
}

struct CartList_Previews: PreviewProvider {
    static var previews: some View {
        CartListView(cart: CartViewModel(), products: [Product.sampleProducts[0]: 1], showDelete: .constant(true))
    }
}
