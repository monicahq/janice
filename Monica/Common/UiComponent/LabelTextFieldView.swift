//
//  LabelTextField.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-09.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import SwiftUI

struct LabelTextFieldView: View {
    @Binding var value :String

    var label: String
    var placeHolder: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
            TextField(placeHolder,
                      text: self.$value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.all)
        }
        .padding(.horizontal, 15)
    }
}

#if DEBUG
struct LabelTextFieldView_Previews: PreviewProvider {
    @State static var value = ""

    static var previews: some View {
        LabelTextFieldView(value: $value, label: "test",
                           placeHolder: "Placeholder")
    }
}
#endif
