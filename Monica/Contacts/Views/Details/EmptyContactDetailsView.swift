//
//  EmptyViewContactDetailsView.swift
//  Monica
//
//  Created by Julien Hamon on 2020-02-18.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftUI

struct EmptyContactDetailsView: View {
    var body: some View {
        VStack {
            Image("peoples_empty")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 25)
            Text("empty_contact_text")
                .font(.SFUIDisplayFontRegularSeventeen())
                .padding(.top, 42)

            Button(action: {
                print("test")
            }, label: {
                Text("Add your first contact")
                .font(.SFUIDisplayFontSemiBoldSeventeen())
                .foregroundColor(Color("Body"))
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 1)
                        .shadow(color: Color("Gray"), radius: 1, y: 2)
                )
            })
            .padding(.top, 65)
            .padding(.horizontal, 50)


        }
    }
}

#if DEBUG
struct EmptyContactDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyContactDetailsView()
            .environment(\.locale, .init(identifier: "en"))
    }
}
#endif
