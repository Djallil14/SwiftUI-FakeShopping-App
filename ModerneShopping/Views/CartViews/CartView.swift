//
//  CartView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct CartView: View {
    init(cartProducts: CartViewModel){
        self.cartProducts = cartProducts
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(Color.background)
        UITableView.appearance().backgroundColor = UIColor(Color.background)
    }
    @ObservedObject var cartProducts: CartViewModel
    var body: some View {
        NavigationView {
            ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                VStack{
                    CartListView(products: cartProducts.cartProduct)
                }
            }.navigationTitle("Cart")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: trailingItem)
        }
    }
    func filterCartProduct(productID: Int, productsIDs: [Int])-> Bool{
        productsIDs.contains(productID)
    }
    var trailingItem: some View {
        Image(systemName:"slider.horizontal.3")
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(cartProducts: CartViewModel())
    }
}
