//
//  ContentView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-01.
//

import SwiftUI

struct ProductView: View {
    @ObservedObject var cart: CartViewModel
    let product: Product
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.top)
            VStack {
                ProductImage(cart: cart, imageURL: product.imageURL).padding(.top)
                ZStack {
                    Color.background.edgesIgnoringSafeArea(.bottom)
                        .cornerRadius(25)
                        .shadow(color: .accentColor.opacity(0.2), radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    VStack(spacing: 0){
                        Text(product.title)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding(24)
                        Text("\(product.price.format(f: ".02"))$")
                            .font(.headline)
                        HStack(spacing: 2) {
                            Text("\(product.formatedRating)").font(.title3)
                            Text("(\(product.rating.manualCount))").font(.caption)
                                .foregroundColor(.secondary)
                                .offset(y: 3)
                        }
                        .padding(8)
                        Text(product.description).italic()
                            .foregroundColor(.secondary)
                            .padding()
                            .multilineTextAlignment(.center)
                        Spacer()
                        Button(action: {
                            cart.addToCart(addedProduct: product)
                        }){
                            HStack {
                                Text("Add to cart").bold()
                            }
                        }.buttonStyle(AddCartButtonStyle())
                        Spacer(minLength: 100)
                    }
                }.edgesIgnoringSafeArea(.bottom)
            }
        }.navigationBarTitleDisplayMode(.large)
    }
}

struct ProductImage: View {
    @ObservedObject var cart: CartViewModel
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: 300, height: 340, alignment: .center)
                .cornerRadius(12)
                .overlay(
                    ZStack {
                        ProgressView()
                        if imageLoader.image != nil {
                            HStack {
                                Spacer()
                                Image(uiImage: imageLoader.image!)
                                    .resizable()
                                    .compositingGroup()
                                    .clipped(antialiased: true)
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(12)
                                    .padding()
                                Spacer()
                            }
                        }
                    }
                )
        }
        .cornerRadius(12)
        .navigationBarItems(trailing: trailingBarItem)
        .onAppear {
            imageLoader.loadImage(with: imageURL)
        }
    }
    var trailingBarItem: some View {
        NavigationLink(destination: CartView(cartProducts: cart)){
        Image(systemName:"cart")
            .imageScale(.large)
            .overlay(
                VStack {
                    if cart.cartProductDic.keys.count > 0 {
                        ZStack {
                            Circle().fill(Color.accentColor)
                            Text("\(cart.cartProductDic.keys.count)")
                                .font(.caption)
                                .foregroundColor(.background)
                        }
                        Spacer()
                    }
                }.offset(x: 10, y: -10)
            )
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(cart: CartViewModel(), product: Product.sampleProducts[6])
    }
}
