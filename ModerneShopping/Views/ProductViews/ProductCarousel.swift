//
//  ProductCarousel.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-08.
//

import SwiftUI

struct ProductCarousel: View {
    private let screenSize = UIScreen.main.bounds
    @EnvironmentObject var cart: CartViewModel
    let products: [Product]
    @State private var product: Product? = nil
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack(spacing: 20){
                ForEach(products){product in
                    Button(action:{
                        withAnimation{
                            self.product = product
                        }
                    }){
                    ProductCarouselCard(product: product)
                        .frame(width: (screenSize.width - 24))
                        .shadow(color: .darkText.opacity(0.1), radius: 3, x: 1, y: 2)
                    }
                }
            }.padding(.leading)
            .sheet(item: $product){product in
                ProductView(product: product).environmentObject(cart)
            }
        }
    }
}

struct ProductCarousel_Previews: PreviewProvider {
    static var previews: some View {
        ProductCarousel(products: Product.sampleProducts)
    }
}
