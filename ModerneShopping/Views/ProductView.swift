//
//  ContentView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-01.
//

import SwiftUI

struct ProductView: View {
    let product: Product
    var body: some View {
        ZStack {
            Color.secondaryBackground.edgesIgnoringSafeArea(.top)
            VStack {
                ProductImage(imageURL: product.imageURL)
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
                            Text("\(product.formatedRating)")
                            Text("(\(product.rating.count))").font(.caption)
                                .foregroundColor(.secondary)
                                .offset(y: 3)
                        }
                        .padding(8)
                        Text(product.description).italic()
                            .foregroundColor(.secondary)
                            .padding()
                            .multilineTextAlignment(.center)
                        Spacer()
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                            HStack {
                                Text("Add to cart").bold()
                            }
                        }.buttonStyle(AddCartButtonStyle())
                        Spacer(minLength: 100)
                    }
                    .navigationBarTitleDisplayMode(.inline)
                }.edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

struct ProductImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.secondaryBackground)
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
        Button(action:{}){
        Image(systemName:"cart")
            .imageScale(.large)
            .overlay(
                VStack {
                    ZStack {
                        Circle().fill(Color.red)
                        Text("1")
                            .font(.caption)
                            .accentColor(.white)
                    }
                    Spacer()
                }.offset(x: 10, y: -10)
            )
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(product: Product.sampleProducts[6])
    }
}
