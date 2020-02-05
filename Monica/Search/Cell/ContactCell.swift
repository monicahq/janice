//
//  ContactCell.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-20.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import SwiftUI

struct ContactCell: View {
    @State var lastname: String
    @State var firstname: String
    @State var nickname: String
    @State var isFavorite: Bool

    var body: some View {
        HStack(spacing: 12.0) {
            ImageLettersView(text: lastname + " " + firstname, width: 41, height: 41)
                .frame(width: 41, height: 41)

            VStack(alignment: .leading) {
                Text(lastname + " " + firstname)
                    .font(.SFUIDisplayFontRegularSeventeen())
                    .fontWeight(.medium)
                    .foregroundColor(Color("Body"))


                if !nickname.isEmpty {
                    Text(nickname)
                        .font(.SFUIDisplayFontRegularTwelve())
                        .foregroundColor(Color("Body"))
                }

            }
            Spacer()

            if isFavorite {
                Image("favorite_star")
                    .resizable().frame(width: 16, height: 16)
            }
        }
        .padding(.trailing, 15)
        .padding(.leading, 15)

    }
}

#if DEBUG
struct ContactCell_Previews: PreviewProvider {
    static var previews: some View {
        List{
            ContactCell(lastname: "name", firstname: "firstname", nickname: "nickname", isFavorite: false)
            ContactCell(lastname: "name", firstname: "firstname", nickname: "", isFavorite: true)
        }
    }
}
#endif
