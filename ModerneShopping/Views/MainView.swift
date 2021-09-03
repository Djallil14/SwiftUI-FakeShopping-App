//
//  MainView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct MainView: View {
    @StateObject var products = ProductsListObject()
    @StateObject var cartItems = CartViewModel()
    var body: some View {
        TabView{
            HomeView(productsList: products, cart: cartItems)
                .tabItem {
                    Image(systemName:"house")
                    Text("Home")
                }
            CartView(cartProducts: cartItems)
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
