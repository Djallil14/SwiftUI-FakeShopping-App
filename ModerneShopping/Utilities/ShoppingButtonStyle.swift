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
                Spacer()
                Image(systemName: "cart")
                    .offset(x: configuration.isPressed ? 60 : -40)
                    .opacity(configuration.isPressed ? 0 : 1)
                    .overlay(
                        Image(systemName: "cart.badge.plus")
                            .offset(x: 40)
                            .opacity(configuration.isPressed ? 1 : 0)
                            .foregroundColor(.white)
                    )
                Spacer()
            }
            HStack {
                Spacer()
                configuration.label
                Spacer()
            }
        }
        .foregroundColor(.white)
        .padding()
        .background(
            Group{
                if configuration.isPressed {
                    Color.green
                } else {
                    Color.accentColor
                }
            }
        )
        .shadow(color: .gray, radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
