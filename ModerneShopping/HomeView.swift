//
//  HomeView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct HomeView: View {
    let product: [Product] = Product.sampleProducts
    var body: some View {
        NavigationView{
            ZStack {
                VStack(alignment: .leading) {
                    Text("Hello.").font(.title).bold()
                        .padding()
                    ProductList(products: product)
                }
            }.navigationBarTitleDisplayMode(.inline)
            .navigationTitle("ModernShopping")
            .navigationBarItems(leading: leadingBarItem, trailing: trailingBarItem)
        }
    }
    
    var leadingBarItem: some View {
        Button(action:{}){
        Image(systemName:"gear")
            .imageScale(.large)
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
