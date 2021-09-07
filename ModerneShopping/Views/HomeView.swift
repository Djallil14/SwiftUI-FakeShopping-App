//
//  HomeView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var productsList: ProductsListObject
    @EnvironmentObject var cart: CartViewModel
    @ObservedObject var user: UserViewModel
    @State var pickedCategory: ProductListEndpoint = .all
    var body: some View {
        NavigationView{
            ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                ScrollView(.vertical){
                    VStack(alignment: .center) {
                        Text("Hello, \(user.user?.results[0].name.first ?? "") \(user.user?.results[0].name.last ?? "Welcome") ! \n Enjoy your shopping 🥳")
                            .font(.title).bold()
                            .multilineTextAlignment(.center)
                            .blendMode(.overlay)
                            .padding()
                        CustomPicker(choosenCategory: $pickedCategory)
                            .onChange(of: pickedCategory, perform: { value in
                                DispatchQueue.main.async {
                                    productsList.loadProducts(with: pickedCategory)
                                }
                            })
                        if productsList.products != nil {
                            ProductList(products: productsList.products!)
                                .environmentObject(cart)
                        } else {
                            LoadingView(isLoading: productsList.isLoading, error: productsList.error){ productsList.loadProducts(with: pickedCategory)
                            }
                        }
                    }
                    .onAppear{
                        DispatchQueue.main.async {
                            productsList.loadProducts(with: pickedCategory)
                        }
                    }
                    Spacer(minLength: 40)
                }
            }.navigationBarTitleDisplayMode(.large)
            .navigationBarItems(
                leading: NavigationLink(destination:ProfilView().environmentObject(user)){
                    if let user = user.user?.results[0]{
                    leadingBarItem(user: user)
                    }
                },
                trailing:
                    TrailingBarItem().environmentObject(cart)
            )
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(productsList: ProductsListObject(), user: UserViewModel()).environmentObject(CartViewModel())
    }
}

struct TrailingBarItem: View {
    @EnvironmentObject var cart: CartViewModel
    var body: some View {
        NavigationLink(destination: CartView(cartProducts: cart)){
            Image(systemName:"cart")
                .foregroundColor(.darkText)
                .imageScale(.large)
                .overlay(
                    VStack {
                        if cart.cartProductDic.keys.count  > 0 {
                            ZStack {
                                Circle().fill(Color.tertiary)
                                Text("\(cart.cartProductDic.keys.count)")
                                    .font(.caption)
                                    .foregroundColor(.darkText)
                            }
                            Spacer()
                        }
                    }.offset(x: 10, y: -10)
                    .shadow(color: .darkText.opacity(0.2), radius: 2, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    
                )
        }
    }
}

struct leadingBarItem: View {
    @StateObject var imageLoader = ImageLoader()
    let user: User
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.secondaryBackground)
                .frame(width: 40, height: 40)
                .overlay(
                    Group{
                        if let image = imageLoader.image{
                            Image(uiImage: image)
                                .resizable()
                                .clipped()
                                .clipShape(Circle())
                        }
                        else {
                            LoadingView(isLoading: imageLoader.isLoading, error: nil, retryAction:{ imageLoader.loadImage(with: URL(string: user.picture.thumbnail)!)})
                        }
                    }
                )
                .overlay(Circle().stroke(lineWidth: 2).foregroundColor(Color.darkText))
        }.onAppear{
            imageLoader.loadImage(with: URL(string: user.picture.thumbnail)!)
        }
    }
    
}
