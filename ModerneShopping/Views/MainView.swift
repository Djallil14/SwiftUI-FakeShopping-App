//
//  MainView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Image(systemName:"house")
                    Text("Home")
                }
            Text("Cart")
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
