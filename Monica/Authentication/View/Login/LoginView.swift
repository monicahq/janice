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

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                self.loginScreen(geometry: geometry)
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(Color("GrayBackground"))
        }
    }

    private func loginScreen(geometry: GeometryProxy) -> some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                headerLoginScreen()
                formLoginScreen()
            }
            
            buttonLoginScreen(geometry: geometry)
            Spacer()

        }

    }

    private func headerLoginScreen() -> some View {
        VStack(alignment: .leading) {
            Text("Welcome back 👋")
                .font(.system(size: 20.0, weight: .semibold, design: .rounded))
                .padding(15)
            Divider()
                .frame(height: 1)
                .background(Color("GrayBackground"))
        }
        .background(Color.white)
        .padding(.bottom, 17)
    }

    private func buttonLoginScreen(geometry: GeometryProxy) -> some View {
        Button(action: {
            self.viewModel.apply(.onButtonCick(login: self.$emailAddress,Password: self.$password))
        }) {
            Text("signin")
                .foregroundColor(Color.white)
                .font(.system(size: 17.0, weight: .semibold, design: .rounded))
        }
        .alert(item: self.$viewModel.haveError, content: { text -> Alert in
            Alert(title: Text("Important message"), message: Text("alert_login_error"), dismissButton: .default(Text("ok")))

        })
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 50.0)
            .background(Color("MonicaBlue"))
            .cornerRadius(8)
            .padding(.horizontal, 30)
            .padding(.top, 30)

    }

    private func formLoginScreen() -> some View {
        VStack {
            Divider()
                .frame(height: 1)
                .background(Color("GrayBackground"))
            LabelTextFieldView(value:self.$emailAddress
                ,label: "email"
                ,placeHolder: "placeholder_email",
                 isSecure: false)
                .padding(.horizontal, 15)
                .padding(.top, 15)
                .padding(.bottom, 5)

            Divider()
                .frame(height: 1)
                .background(Color("GrayBackground"))
                .padding(.horizontal, 15)

            LabelTextFieldView(value:self.$password
                ,label: "password"
                ,placeHolder: "placeholder_password",
                 isSecure: true)
                .padding(.horizontal, 15)
                .padding(.top, 15)
                .padding(.bottom, 5)

            Divider()
                .frame(height: 1)
                .background(Color("GrayBackground"))
        }
        .background(Color.white)
    }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: .init())
            .environment(\.locale, .init(identifier: "en"))

    }
}
#endif
