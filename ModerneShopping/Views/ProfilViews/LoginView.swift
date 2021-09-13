//
//  LoginView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-08.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var user: UserViewModel
    @State private var isNameValid: Bool? = nil
    @State private var isPasswordValid: Bool? = nil
    @State private var showPassword: Bool = false
    @State private var showSheet: Bool = false
    var body: some View {
        ZStack{
            Color.background.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center,spacing: 16){
                Text("Login")
                    .font(.title3).bold()
                LoginLottieView()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                VStack{
                    HStack {
                        LoginTextView(name: $user.login, isValid: $user.isNameValid)
                        if let nameValid = user.isNameValid{
                            if nameValid {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                                    .padding(8)
                            } else {
                                Image(systemName: "xmark")
                                    .foregroundColor(.red)
                                    .padding(8)
                            }
                        }
                    }
                    HStack {
                        PasswordTextView(name: $user.password, isValid: $user.isPasswordValid, showPassword: $showPassword)
                        if let passwordValid = user.isPasswordValid{
                            if passwordValid {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                                    .padding(8)
                            } else {
                                Image(systemName: "xmark")
                                    .foregroundColor(.red)
                                    .padding(8)
                            }
                        }
                    }
                    HStack{
                        Button(action:{withAnimation{
                            showSheet.toggle()
                        }}){
                            Text("Forgot Password ?")
                                .font(.subheadline).bold()
                        }
                        .padding(8)
                        Spacer()
                    }
                    Button(action: {
                        user.validateName(name: user.login)
                        user.validatePassword(name: user.password)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            if user.isNameValid == true &&
                                user.isPasswordValid == true {
                                withAnimation{
                                    user.loadUser()
                                }
                            } else {
                                withAnimation{
                                    user.isNameValid = nil
                                    user.isPasswordValid = nil
                                }
                            }
                        }
                    }){
                        Text("Sign In")
                            .foregroundColor(.darkText)
                            .font(.headline)
                            .padding()
                            .background(Color.secondaryBackground)
                            .cornerRadius(16)
                            .shadow(color: .darkText.opacity(0.2), radius: 2, x: 1.0, y: 2)
                    }
                    Button(action:{withAnimation{
                        showSheet.toggle()
                    }}){
                        Text("Create an account").font(.headline)
                            .foregroundColor(.darkText)
                            .shadow(color: .darkText.opacity(0.1), radius: 2, x: 1, y: 2)
                    }
                }
                .padding()
                .background(Color.secondaryBackground)
                .cornerRadius(16)
                Spacer()
            }.padding()
            .sheet(isPresented: $showSheet){
                Text("Create an account or forgot password")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(UserViewModel())
        
    }
}

struct LoginTextView: View{
    @Binding var name: String
    @Binding var isValid: Bool?
    var body: some View {
        HStack {
            TextField("Username",text: $name)
                .padding()
                .background(Color.background)
                .cornerRadius(16)
                .shadow(color: .borderColor(condition: isValid), radius: 2, x: 0.0, y: 0.0)
                .disableAutocorrection(true)
                .autocapitalization(.none)
        }
    }

}

struct PasswordTextView: View{
    @Binding var name: String
    @Binding var isValid: Bool?
    @Binding var showPassword: Bool
    var body: some View {
        Group{
            if !showPassword{
                HStack {
                    SecureField("Password",text: $name)
                        .padding()
                        .background(Color.background)
                        .cornerRadius(16)
                        .shadow(color: .borderColor(condition: isValid), radius: 2, x: 0.0, y: 0.0)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    Button(action:{
                        withAnimation{
                            showPassword.toggle()
                        }
                    }){
                        Image(systemName: "eye")
                            .imageScale(.large)
                    }
                }
            } else {
                HStack {
                    LoginTextView(name: $name,isValid: $isValid)
                    Button(action:{showPassword.toggle()}){
                        Image(systemName: "eye.slash")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}
