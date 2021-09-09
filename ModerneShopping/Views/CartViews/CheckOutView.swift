//
//  CheckOutView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-07.
//

import SwiftUI

struct CheckOutView: View {
    @EnvironmentObject var cart: CartViewModel
    let products: [Product]
    let price:Double
    var taxes: Double {
        (price * 20 / 100)
    }
    var delivery: Double {
        if price > 100 {
            return 0
        } else {
            return 50
        }
    }
    var body: some View {
        VStack {
            Spacer()
            ZStack{
                Color.background.edgesIgnoringSafeArea(.bottom)
                Color.secondaryBackground.opacity(0.3).edgesIgnoringSafeArea(.bottom)
                VStack(alignment:.center, spacing: 0){
                    HStack{
                        Button(action: {withAnimation{cart.showShowcaseSheet.toggle()}}, label: {
                            Image(systemName: "xmark")
                                .imageScale(.medium)
                                .foregroundColor(.darkText)
                        }).padding(8)
                        .background(Color.secondaryBackground)
                        .clipShape(Circle())
                        Spacer()
                    }.padding()
                    Spacer()
                    ForEach(products){product in
                        HStack {
                            Text(product.title)
                                .font(.caption)
                                .lineLimit(1)
                            Text("\(product.price.format(f: ".2"))$").bold()
                            Spacer()
                        }.padding(.horizontal)
                        .foregroundColor(.darkText)
                        .background(Color.background)
                        .padding(.horizontal)
                    }
                    
                    Text("Taxes: \(taxes.format(f: ".02"))$")
                        .font(.caption)
                        .padding(.top)
                    Text("Delivery: \(delivery.format(f: ".02"))$")
                        .font(.caption)
                    Text("Final Price: \((price + taxes + delivery).format(f: ".02"))$")
                        .font(.caption)
                    Button(action: {print("Paying ...")}) {
                        Text("Click Here to Pay").bold()
                            .padding()
                            .background(Color.secondaryBackground)
                            .cornerRadius(18)
                    }.padding()
                }.foregroundColor(.darkText)
                Spacer()
            }.cornerRadius(12)
            .frame(height: 300)
        }
        .transition(.move(edge: .bottom))
        .zIndex(20)
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(products: Array(Product.sampleProducts[0...2]), price: 500)
    }
}
