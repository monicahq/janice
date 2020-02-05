//
//  LoginView.swift
//  Monica
//
//  Created by Julien Hamon on 2019-11-25.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel:LoginViewModel
    @State private var password = ""
    @State private var emailAddress = ""

    @State private var isActive = false

    var body: some View {

        GeometryReader { geometry in
            Form {
                LabelTextFieldView(value:self.$emailAddress
                    ,label: "Email"
                    ,placeHolder: "Enter your Email.")

                Text("label")
                    .font(.headline)
                SecureField("Enter a password", text: self.$password)

                Button(action: {
                    self.viewModel.apply(.onButtonCick(login: self.$emailAddress,Password: self.$password))
                }) {
                    Text("Sign in")
                        .foregroundColor(Color.white)
                        .font(.system(size: 17.0, weight: .semibold, design: .rounded))
                }
                .frame(width: geometry.size.width - 30, height: 50.0)
                .background(Color("MonicaBlue"))
                .cornerRadius(8)
            }
        }
    }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: .init())
    }
}
#endif
