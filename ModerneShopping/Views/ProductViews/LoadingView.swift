//
//  LoadingView.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-02.
//

import SwiftUI

struct LoadingView: View {
    let isLoading: Bool
    let error: NSError?
    let retryAction: (() -> ())?
    var body: some View {
        Group {
            if isLoading{
                VStack {
                    Spacer()
                    HStack{
                        Spacer()
                        ProductLoading()
                            .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                    Spacer()
                }
            } else if error != nil {
                Text("Can't load the products")
                if retryAction != nil {
                    Button(action: retryAction!){
                        Text("retry")
                    }
                }
            } else {
                EmptyView()
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: true, error: nil, retryAction: nil)
    }
}
