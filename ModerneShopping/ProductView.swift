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
        VStack {
            ProductImage(imageURL: product.imageURL)
            Text(product.title)
                .font(.headline)
                .padding()
            Text("\(product.price.format(f: ".02"))$")
                .font(.headline)
            HStack(spacing: 2) {
                Text("\(product.formatedRating)")
                Text("(\(product.rating.count))").font(.caption)
                    .foregroundColor(.secondary)
                    .offset(y: 3)
            }
            .padding()
            Text(product.description).italic()
                .foregroundColor(.secondary)
                .padding()
                .multilineTextAlignment(.center)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                HStack {
                    Text("Add to cart").bold()
                }
            }.buttonStyle(AddCartButtonStyle())
            Spacer()
        }
    }
}

struct ProductImage: View {
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
