//
//  UserViewModel.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-06.
//

import Foundation

class  UserViewModel: ObservableObject {
    @Published var user: Results?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private let userServices: APIServices
    
    init(userServices: APIServices = APIServices.shared){
        self.userServices = userServices
    }
    
    func loadUser(){
        self.user = nil
        DispatchQueue.main.async {
            self.isLoading = true
        }
        userServices.fetchUser { (result) in
            DispatchQueue.main.async {
            self.isLoading = true
            }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.user = response
                    self.isLoading = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                self.error = error as NSError
                }
            }
        }
    }
}
