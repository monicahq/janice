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
    var isSecure:Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text(NSLocalizedString(label, comment: label))
                .font(.system(size: 11.0, weight: .regular, design: .rounded))
                .foregroundColor(Color("Body"))
            if isSecure {
                SecureField(NSLocalizedString(placeHolder, comment: placeHolder), text: $value)
                .padding(.top, 5)

            } else {
                TextField(NSLocalizedString(placeHolder, comment: placeHolder),
                      text: $value)
                .padding(.top, 5)
            }

        }
    }
}

#if DEBUG
struct LabelTextFieldView_Previews: PreviewProvider {
    @State static var value = ""

    static var previews: some View {
        Group {
            LabelTextFieldView(value: $value, label: "email",
            placeHolder: "Placeholder", isSecure: false)
            LabelTextFieldView(value: $value, label: "test",
                       placeHolder: "Placeholder", isSecure: true)
        }.environment(\.locale, .init(identifier: "en"))


    }
}
#endif
