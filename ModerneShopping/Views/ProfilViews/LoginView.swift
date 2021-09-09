//
//  LoginView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-08.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var user: UserViewModel
    @State private var isEditing: Bool = false
    @State private var isValid: Bool = false
    @State private var showPassword: Bool = false
    var body: some View {
        ZStack{
            Color.background.edgesIgnoringSafeArea(.all)
            VStack(alignment: .center,spacing: 16){
                LoginLottieView()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                LoginTextView(name: $user.login, isEditing: $isEditing, isValid: $isValid)
                PasswordTextView(name: $user.password, isEditing: $isEditing, isValid: $isValid, showPassword: $showPassword)
                Button(action: {user.loadUser()}){
                    Text("Sign In")
                        .font(.headline)
                        .padding()
                        .background(Color.secondaryBackground)
                        .cornerRadius(16)
                        .shadow(color: .darkText.opacity(0.2), radius: 2, x: 1.0, y: 2)
                }
                Spacer()
            }.padding()
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
    @Binding var isEditing: Bool
    @Binding var isValid: Bool
    var body: some View {
        HStack {
            TextField(
                    "User name (email address)",
                text: $name
                ) { isEditing in
                    self.isEditing = isEditing
                } onCommit: {
                    validate(name: name)
                }
            .padding()
            .background(Color.background)
            .cornerRadius(16)
            .shadow(color: .darkText.opacity(0.2), radius: 2, x: 0.0, y: 0.0)
            .disableAutocorrection(true)
            .autocapitalization(.none)
        }
    }
    private func validate(name: String){
        isValid = true
    }
}

struct PasswordTextView: View{
    @Binding var name: String
    @Binding var isEditing: Bool
    @Binding var isValid: Bool
    @Binding var showPassword: Bool
    var body: some View {
        Group{
            if !showPassword{
                HStack {
                    SecureField(
                                "User name (email address)",
                            text: $name
                            ){
                                validate(name: name)
                            }
                        .padding()
                        .background(Color.background)
                        .cornerRadius(16)
                        .shadow(color: .darkText.opacity(0.2), radius: 2, x: 0.0, y: 0.0)
                        .disableAutocorrection(true)
                    .autocapitalization(.none)
                    Button(action:{showPassword.toggle()}){
                        Image(systemName: "eye")
                            .imageScale(.large)
                    }
                }
            } else {
                HStack {
                    LoginTextView(name: $name, isEditing: $isValid, isValid: $isValid)
                    Button(action:{showPassword.toggle()}){
                        Image(systemName: "eye.slash")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
    private func validate(name: String){
        isValid = true
    }
}
