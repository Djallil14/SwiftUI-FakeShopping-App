//
//  UserViewModel.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-06.
//

import SwiftUI

class  UserViewModel: ObservableObject {
    @Published var user: Results?
    @Published var isLoading = false
    @Published var error: NSError?
    @Published var isLoggedin = false
    @Published var login = "admin@admin.com"
    @Published var password = "admin"
    @Published var isNameValid: Bool? = nil
    @Published var isPasswordValid: Bool? = nil
    
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
     func signout(){
        isLoading = true
        self.user = nil
        isLoading = false
    }
    func validateName(name: String){
        guard name.count > 5 && name.count < 24 else {
            withAnimation{
            isNameValid = false
            }
            return
        }
        guard name.contains("@") else {
            withAnimation{
            isNameValid = false
            }
            return
        }
        withAnimation{
        isNameValid = true
        }
    }
    func validatePassword(name: String){
        guard name.count >= 5 && name.count < 24 else {
            withAnimation{
            isPasswordValid = false
            }
            return
        }
        withAnimation{
        isPasswordValid = true
        }
    }
}
