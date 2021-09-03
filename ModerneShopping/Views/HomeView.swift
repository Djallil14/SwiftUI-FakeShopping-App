//
//  HomeView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var productsList: ProductsListObject
    @ObservedObject var cart: CartViewModel
    let product: [Product] = Product.sampleProducts
    @State var pickedCategory: ProductListEndpoint = .all
    var body: some View {
        NavigationView{
            ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                ScrollView(.vertical){
                    VStack(alignment: .center) {
                        Text("Welcome to Modern Shopping.")
                            .font(.title).bold()
                            .multilineTextAlignment(.center)
                            .blendMode(.overlay)
                            .padding()
                        CustomPicker(choosenCategory: $pickedCategory)
                            .onChange(of: pickedCategory, perform: { value in
                                    productsList.loadProducts(with: pickedCategory)
                                    print(pickedCategory)
                            })
                        if productsList.products != nil {
                            ProductList(cart: cart, products: productsList.products!)
                        } else {
                            LoadingView(isLoading: productsList.isLoading, error: productsList.error){ productsList.loadProducts(with: pickedCategory)
                            }
                        }
                    }
                    Spacer(minLength: 40)
                }
            }.navigationBarTitleDisplayMode(.inline)
            .navigationTitle("ModernShopping")
            .navigationBarItems(leading: leadingBarItem, trailing: trailingBarItem)
        }.onAppear{
            productsList.loadProducts(with: .all)
        }
    }
    
    var leadingBarItem: some View {
        Button(action:{}){
            Image(systemName:"slider.horizontal.3")
                .imageScale(.large)
        }
    }
    var trailingBarItem: some View {
        NavigationLink(destination: CartView(cartProducts: cart)){
            Image(systemName:"cart")
                .imageScale(.large)
                .overlay(
                    VStack {
                        if cart.cartProduct.count > 0 {
                            ZStack {
                                Circle().fill(Color.red)
                                Text("\(cart.cartProduct.count)")
                                    .font(.caption)
                                    .accentColor(.white)
                            }
                            Spacer()
                        }
                    }.offset(x: 10, y: -10)
                    
                )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(productsList: ProductsListObject(), cart: CartViewModel())
    }
}

