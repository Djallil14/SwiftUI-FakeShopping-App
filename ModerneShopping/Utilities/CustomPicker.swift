//
//  CustomPicker.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct CustomPicker: View {
    @Binding var choosenCategory: ProductListEndpoint
    var body: some View {
        HStack(spacing:0){
            ForEach(ProductListEndpoint.allCases, id: \.self){category in
                VStack {
                    Button(action: {
                        withAnimation(.spring()){
                            choosenCategory = category
                        }
                    }){
                        Text(category.rawValue)
                            .bold()
                            .font(.caption2)
                            .padding(8)
                            .multilineTextAlignment(.center)
                            .foregroundColor(choosenCategory == category ? .tertiary : .allBlack)
                    }
                    .frame(height: 40)
                    .background(choosenCategory == category ? Color.accentColor : Color.secondaryBackground)
                    .cornerRadius(25)
                }
            }
        }
        .frame(height: 40)
        .background(Color.secondaryBackground)
        .cornerRadius(25)
        .shadow(color: .accentColor.opacity(0.2), radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
    }
}

struct CustomPicker_Previews: PreviewProvider {
    static var previews: some View {
        CustomPicker(choosenCategory: .constant(.all))
    }
}
