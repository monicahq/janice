//
//  SigninView.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-08.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import SwiftUI

struct SigninView: View {

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .top, content: {
                    Image("background")
                        .resizable()
                        .aspectRatio(geometry.size, contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                    VStack(alignment: .center, spacing: 29, content:  {
                        Image("panda")
                            .padding(.top, 43)

                        Text("Monica is your private personal space to document everything you know about the most important people in your life.")
                            .foregroundColor(Color.white)
                            .font(.SFUIDisplayFontRegularSeventeen())
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 15.0)
                            .padding(.bottom, 15.0)


                        NavigationLink(destination: LoginView(viewModel: .init())) {
                            Text("Sign in")
                                .foregroundColor(Color("MonicaBlue"))
                                .font(.system(size: 17.0, weight: .semibold, design: .rounded))
                                .frame(width: geometry.size.width - 30, height: 50.0)
                                .background(Color.white)
                                .cornerRadius(8)
                        }
                    })
                })
            }
        }
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}
