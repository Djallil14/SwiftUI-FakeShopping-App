//
//  ProductList.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct ProductList: View {
    let products: [Product]
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
            VStack{
                
                ScrollView(.vertical){
                    Spacer(minLength: 20)
                LazyVGrid(columns: columns){
                        ForEach(products){product in
                            NavigationLink(destination:ProductView(product: product)){
                            ProductListItem(product: product)
                            }.accentColor(.primary)
                        }
                    }
                    Spacer()
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
    }

}

struct ProductList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView  {
        ProductList(products: Product.sampleProducts)
        }
    }
}

