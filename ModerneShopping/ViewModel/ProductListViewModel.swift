//
//  ProductListViewModel.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import Foundation

class  ProductsListObject: ObservableObject {
    @Published var products: [Product]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private let productListServices: APIServices
    
    init(productServices: APIServices = APIServices.shared){
        self.productListServices = productServices
    }
    
    func loadProducts(with url: ProductListEndpoint){
        self.products = nil
        DispatchQueue.main.async {
            self.isLoading = true
        }
        productListServices.fetchProducts(from: url) { (result) in
            DispatchQueue.main.async {
            self.isLoading = true
            }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.products = response
                    self.isLoading = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                self.error = error as NSError
                }
            }
        }
    }
}
