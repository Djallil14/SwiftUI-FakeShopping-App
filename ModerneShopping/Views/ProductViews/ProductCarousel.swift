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
    @State private var currentIndex: Int = 0
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    init(products: [Product]) {
        self.products = products
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.darkText)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color.secondaryBackground)
    }
    var body: some View {
        VStack(spacing:0) {
            TabView(selection: $currentIndex){
                ForEach(0..<products.count, id: \.self){index in
                    Button(action:{
                        withAnimation{
                            self.product = products[index]
                        }
                    }){
                        ProductCarouselCard(product: products[index])
                            .frame(width: (screenSize.width - 24))
                            .shadow(color: .darkText.opacity(0.1), radius: 3, x: 1, y: 2)
                    }
                    .tag(index)
                }
            }
            .frame(height: 220)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .sheet(item: $product){product in
                ProductView(product: product).environmentObject(cart)
            }
            .onReceive(timer) { input in
                animateCarousel()
            }
        }
    }
    func animateCarousel(){
        if currentIndex <= 3 {
            withAnimation{
            currentIndex += 1
            }
        } else {
            withAnimation{
            currentIndex = 0
            }
        }
    }
}

struct ProductCarousel_Previews: PreviewProvider {
    static var previews: some View {
        ProductCarousel(products: Product.sampleProducts)
    }
}

