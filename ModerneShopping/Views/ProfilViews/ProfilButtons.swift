//
//  ProfilButtons.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-06.
//

import SwiftUI

struct ProfilButtons: View {
    @EnvironmentObject var user: UserViewModel
    var body: some View {
        VStack {
            NavigationLink(destination: ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                Text("Update Account")
            }){
                HStack {
                    Text("Update Account")
                    Image(systemName: "slider.horizontal.3")
                }.font(.headline)
                .padding()
                .background(Color.secondaryBackground)
                .cornerRadius(12)
                .shadow(color: .accentColor.opacity(0.1), radius: 2, x: 0.5, y: 1)
            }
            NavigationLink(destination: ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                Text("History")
            }){
                HStack {
                    Text("History")
                    Image(systemName: "cart.fill")
                }.font(.headline)
                .padding()
                .background(Color.secondaryBackground)
                .cornerRadius(12)
                .shadow(color: .accentColor.opacity(0.1), radius: 2, x: 0.5, y: 1)
            }
            NavigationLink(destination: ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                Text("Orders")
            }){
                HStack {
                    Text("Orders")
                    Image(systemName: "bag.circle")
                }.font(.headline)
                .padding()
                .background(Color.secondaryBackground)
                .cornerRadius(12)
                .shadow(color: .accentColor.opacity(0.1), radius: 2, x: 0.5, y: 1)
            }
            Button(action:{withAnimation{user.signout()}}){
                HStack {
                    Text("Sign out")
                    Image(systemName: "person.crop.circle.fill.badge.xmark")
                }.font(.headline)
                .padding()
                .background(Color.secondaryBackground)
                .cornerRadius(12)
                .shadow(color: .accentColor.opacity(0.1), radius: 2, x: 0.5, y: 1)
            }
        }.padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProfilButtons_Previews: PreviewProvider {
    static var previews: some View {
        ProfilButtons()
    }
}
