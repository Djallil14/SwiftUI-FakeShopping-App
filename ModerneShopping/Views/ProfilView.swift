//
//  ProfilView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-05.
//

import SwiftUI

struct ProfilView: View {
    @EnvironmentObject var user: UserViewModel
    @StateObject var imageLoader = ImageLoader()
    var body: some View {
        VStack{
            if let user = user.user?.results[0]{
                LoggedInView(user: user)
            } else {
                LoadingView(isLoading: user.isLoading, error: user.error, retryAction: user.loadUser)
            }
        }
    }
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView()
            .environmentObject(UserViewModel())
    }
}
