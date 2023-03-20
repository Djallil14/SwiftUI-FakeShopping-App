//
//  CartListItem.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct CartListItem: View {
    @ObservedObject var cart: CartViewModel
    let product: Product
    @State var quantity: Int = 0
    var body: some View {
        HStack(spacing: 16) {
            SmallCartListItemImage(imageURL: product.imageURL)
            VStack {
                Text(product.title)
                    .font(.headline)
                    .lineLimit(2)
                Text("\((product.price * Double(quantity)).format(f: ".2")) $")
            }
            Spacer()
            Picker(selection: $quantity, label: Text("Picker"), content: {
                ForEach(1...10, id:\.self){quantity in
                    Text("\(quantity)")
                        .tag(quantity)
                }.onChange(of: quantity, perform: { value in
                    cart.changeQuantity(product: product, quantity: quantity)
                })
            })
            .pickerStyle(WheelPickerStyle())
            .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .clipped()
            .padding(.trailing)
        }
        .padding(.vertical)
        .padding(.leading, 8)
        .background(Color.background)
        .onAppear{
            if let quantity = cart.cartProductDic[product]{
                self.quantity = quantity
            }
        }
    }
}

struct CartListItem_Previews: PreviewProvider {
    static var previews: some View {
        CartListItem(cart: CartViewModel(), product: Product.sampleProducts[1], quantity: 3)
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
                        //if imageLoader.image != nil {
                            HStack {
                                Spacer()
//                                Image(uiImage: imageLoader.image!)
//                                    .resizable()
//                                    .compositingGroup()
//                                    .aspectRatio(contentMode: .fit)
                                AsyncImage(url: imageURL, scale: 7.0)
                                    .scaledToFit()
                                Spacer()
                            }
                        //}
                    }.padding()
                )
        }
        .cornerRadius(12)
        .shadow(color: .gray, radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
        .onAppear {
            //imageLoader.loadImage(with: imageURL)
        }
    }
}
