//
//  ShoppingButtonStyle.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-01.
//

import SwiftUI

struct AddCartButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "cart")
                    .offset(x: configuration.isPressed ? 60 : 0)
                    .opacity(configuration.isPressed ? 0 : 1)
                    .overlay(
                        Image(systemName: "cart.badge.plus")
                            .offset(x: 60)
                            .opacity(configuration.isPressed ? 1 : 0)
                            .foregroundColor(.white)
                    )
            }
            configuration.label
        }
        .foregroundColor(.white)
        .padding()
        .background(
            Group{
                if configuration.isPressed {
                    Color.green
                } else {
                    Color.red
                }
            }
        )
        .shadow(color: .gray, radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
        .cornerRadius(12)
    }
}
