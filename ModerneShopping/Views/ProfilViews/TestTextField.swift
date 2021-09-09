//
//  TestTextField.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-09.
//

import SwiftUI

struct testTextField: View {
    @State var output: String = ""
    @State var input: String = ""
    @State var typing = false
    var body: some View {
        VStack {
            if !typing {
                if !output.isEmpty {
                    Text("You typed: \(output)")
                }
            } else if !input.isEmpty {
                Text("You are typing: \(input)")
            }
            TextField("", text: $input, onEditingChanged: {
                self.typing = $0
            }, onCommit: {
                self.output = self.input
            })
            .background(Color.green.opacity(0.2))
        }
    }
}

struct testTextField_Previews: PreviewProvider {
    static var previews: some View {
        testTextField()
    }
}
