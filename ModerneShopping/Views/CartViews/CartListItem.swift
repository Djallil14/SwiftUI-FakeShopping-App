//
//  CartListItem.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct CartListItem: View {
    let product: Product
    var body: some View {
        HStack(spacing: 16) {
            SmallCartListItemImage(imageURL: product.imageURL)
            Text(product.title)
                .font(.headline)
                .lineLimit(2)
            Spacer()
        }
        .padding(.vertical)
        .padding(.leading, 8)
        .background(Color.background)
    }
}

struct CartListItem_Previews: PreviewProvider {
    static var previews: some View {
        CartListItem(product: Product.sampleProducts[1])
    }
}

struct SmallCartListItemImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: 100, height: 100, alignment: .center)
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
                                    .aspectRatio(contentMode: .fit)
                                Spacer()
                            }
                        }
                    }.padding()
                )
        }
        .cornerRadius(12)
        .shadow(color: .gray, radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
        .onAppear {
            imageLoader.loadImage(with: imageURL)
        }
    }
}
