//
//  CartView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var user: UserViewModel
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
                    if cartProducts.cartProductDic.isEmpty {
                        CartLoadingView()
                    } else {
                    CartListView(cart: cartProducts, products: cartProducts.cartProductDic)
                    }
                    Text("Total: \(cartProducts.totalPrice.format(f: ".2"))$")
                    Button(action: {}, label: {
                        HStack {
                            Text("Check out").bold()
                            Image(systemName: "creditcard")
                        }.padding()
                        .foregroundColor(.tertiary)
                    })
                    .background(Color.accentColor)
                    .cornerRadius(12)
                    .padding()
                }.onChange(of: cartProducts.cartProductDic, perform: { value in
                    cartProducts.calculateTotalPrice()
                })
            }.navigationTitle("Cart")
            .navigationBarItems(trailing: trailingItem)
        }.onAppear{
            cartProducts.calculateTotalPrice()
        }
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
