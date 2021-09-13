//
//  Extension+Colors.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-03.
//

import SwiftUI

extension Color {
    static let background: Color = Color("Background")
    static let secondaryBackground: Color = Color("SecondaryBackground")
    static let tertiary: Color = Color("tertiary")
    static let darkText: Color = Color("darkText")
    
    /// Change color of the border shadow depending on the user when he click sign in on LoginView
    /// - Parameter condition: an optional bool that will affect the color that is returned
    /// - Returns: a Color
    static func borderColor(condition: Bool?)-> Color{
        switch condition {
        case .some(true):
            return Color.green.opacity(0.8)
        case .some(false):
            return Color.red.opacity(0.8)
        case .none:
            return Color.darkText.opacity(0.2)
        }
    }
}
