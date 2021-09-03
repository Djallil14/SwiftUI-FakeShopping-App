//
//  HomeView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct HomeView: View {
    @StateObject var productsList = ProductsListObject()
    let product: [Product] = Product.sampleProducts
    @State var pickedCategory: ProductListEndpoint = .all
    var body: some View {
        NavigationView{
            ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                ScrollView(.vertical){
                    VStack(alignment: .center) {
                        Text("Welcome to Modern Shopping.")
                            .font(.title).bold()
                            .multilineTextAlignment(.center)
                            .blendMode(.overlay)
                            .padding()
                        CustomPicker(action: {
                            productsList.loadProducts(with: pickedCategory)
                            print(pickedCategory)
                        }, choosenCategory: $pickedCategory)
                        if productsList.products != nil {
                            ProductList(products: productsList.products!)
                        } else {
                            LoadingView(isLoading: productsList.isLoading, error: productsList.error){ productsList.loadProducts(with: pickedCategory)
                            }
                        }
                    }
                }
            }.navigationBarTitleDisplayMode(.inline)
            .navigationTitle("ModernShopping")
            .navigationBarItems(leading: leadingBarItem, trailing: trailingBarItem)
        }.onAppear{
            productsList.loadProducts(with: .jewelery)
        }
    }
    
    var leadingBarItem: some View {
        Button(action:{}){
            Image(systemName:"gear")
                .imageScale(.large)
        }
    }
    var trailingBarItem: some View {
        Button(action:{}){
            Image(systemName:"cart")
                .imageScale(.large)
                .overlay(
                    VStack {
                        ZStack {
                            Circle().fill(Color.red)
                            Text("1")
                                .font(.caption)
                                .accentColor(.white)
                        }
                        Spacer()
                    }.offset(x: 10, y: -10)
                    
                )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension Color {
    static let background: Color = Color("Background")
    static let secondaryBackground: Color = Color("SecondaryBackground")
}
