//
//  StoreView.swift
//  ModerneShopping
//
//  Created by Brian Riviere on 2023-03-19.
//

import SwiftUI


struct StoreView: View {
    var body: some View {
        ARContainerView(sessionRunOptions: [.removeExistingAnchors, .resetTracking])
    }
}



struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}
