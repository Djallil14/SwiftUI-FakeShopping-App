//
//  FillAndStrokeShape.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-11.
//

import SwiftUI

struct FillAndStrokeShape: View {
    var body: some View {
        strokeAndFilledCircle(strokeColor: Color.blue, lineWidth: 10, fillColor: Color.red)
    }

    func strokeAndFilledCircle(strokeColor: Color,lineWidth: CGFloat, fillColor: Color)-> some View{
        let circle = Circle()
        
        return
            ZStack{
                circle.fill(fillColor)
                circle.stroke(lineWidth: lineWidth)
                       .fill(strokeColor)
        }
    }
}
