//
//  HomeView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var productsList: ProductsListObject
    @ObservedObject var cart: CartViewModel
    @ObservedObject var user: UserViewModel
    let product: [Product] = Product.sampleProducts
    @State var pickedCategory: ProductListEndpoint = .all
    var body: some View {
        NavigationView{
            ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                ScrollView(.vertical){
                    VStack(alignment: .center) {
                        Text("Hello, \(user.user?.results[0].name.first ?? "") \(user.user?.results[0].name.last ?? "Welcome")🥳")
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
                            ProductList(cart: cart, products: productsList.products!)
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
                    leadingBarItem(user: user.user?.results[0] ?? User.sampleProducts.results[0])
                },
                trailing:
                    trailingBarItem
            )
        }
    }
    
    var trailingBarItem: some View {
        NavigationLink(destination: CartView(cartProducts: cart)){
            Image(systemName:"cart")
                .imageScale(.large)
                .overlay(
                    VStack {
                        if cart.cartProductDic.keys.count  > 0 {
                            ZStack {
                                Circle().fill(Color.accentColor)
                                Text("\(cart.cartProductDic.keys.count)")
                                    .font(.caption)
                                    .foregroundColor(.background)
                            }
                            Spacer()
                        }
                    }.offset(x: 10, y: -10)
                    
                )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(productsList: ProductsListObject(), cart: CartViewModel(), user: UserViewModel())
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
                    }
                )
                .overlay(Circle().stroke(lineWidth: 2).foregroundColor(Color.accentColor))
        }.onAppear{
            imageLoader.loadImage(with: URL(string: user.picture.thumbnail)!)
        }
    }
    
}
