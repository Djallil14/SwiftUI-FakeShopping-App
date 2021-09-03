//
//  CustomPicker.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct CustomPicker: View {
    var action: () -> Void
    @Binding var choosenCategory: ProductListEndpoint
    var body: some View {
        HStack(spacing:0){
            ForEach(ProductListEndpoint.allCases, id: \.self){category in
                VStack {
                    Button(action: action){
                        Text(category.rawValue)
                            .bold()
                            .font(.caption)
                            .padding(8)
                            .multilineTextAlignment(.center)
                            .foregroundColor(choosenCategory == category ? .white : .accentColor)
                    }
                    .frame(height: 40)
                    .background(choosenCategory == category ? Color.blue : Color.secondaryBackground)
                }
            }
        }
        .frame(height: 40)
        .background(Color.secondaryBackground)
        .cornerRadius(12)
        .shadow(color: .accentColor.opacity(0.2), radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
    }
}

struct CustomPicker_Previews: PreviewProvider {
    static var previews: some View {
        CustomPicker(action: {}, choosenCategory: .constant(.all))
    }
}
