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
        // using UIKit list styling (iOS 15 fixes that)
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(Color.background)
        UITableView.appearance().backgroundColor = UIColor(Color.background)
    }
    @ObservedObject var cartProducts: CartViewModel
    @State var showDelete: Bool = false
    var body: some View {
        let productsDic = cartProducts.cartProductDic.map({$0.key})
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            VStack{
                if !productsDic.isEmpty{
                    HStack{
                        Text("Cart")
                            .font(.title2).bold()
                        Spacer()
                        trailingItem
                            
                    }.padding()
                }
                if cartProducts.cartProductDic.isEmpty {
                    CartLoadingView()
                } else {
                    CartListView(cart: cartProducts, products: cartProducts.cartProductDic, showDelete: $showDelete)
                }
                Text("Total: \(cartProducts.totalPrice.format(f: ".2"))$")
                Button(action: {withAnimation{cartProducts.showShowcaseSheet.toggle()}}, label: {
                    HStack {
                        Text("Check out").bold()
                        Image(systemName: "creditcard")
                    }.padding()
                    .foregroundColor(.tertiary)
                })
                .background(Color.accentColor)
                .cornerRadius(12)
                .padding()
                .disabled(cartProducts.cartProductDic.isEmpty)
            }.onChange(of: cartProducts.cartProductDic, perform: { value in
                cartProducts.calculateTotalPrice()
            })
        }.accentColor(.darkText)
        .overlay(
            Group {
                if cartProducts.showShowcaseSheet{
                    CheckOutView(products: productsDic, price: cartProducts.totalPrice).environmentObject(cartProducts)
                } else {
                    EmptyView()
                }
            }
        )
        .onAppear{
            showDelete = false
            cartProducts.calculateTotalPrice()
        }
    }
    var trailingItem: some View {
        Button(action:{withAnimation {showDelete.toggle()}}){
            Image(systemName:"slider.horizontal.3")
        }.accentColor(.darkText)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(cartProducts: CartViewModel())
    }
}
