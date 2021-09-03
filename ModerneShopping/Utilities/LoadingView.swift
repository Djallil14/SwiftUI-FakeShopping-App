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
                HStack{
                    Spacer()
                ProgressView()
                    Spacer()
                }
            } else if error != nil {
                Text("shit")
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
