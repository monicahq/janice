//
//  ContactTitleCellView.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-11.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftUI

struct ContactTitleCellView: View {

    var contact: Contact
    @EnvironmentObject var showModal: ShowModal

    private  let spacing: CGFloat = 15

    var body: some View {
        ZStack{
            HStack(alignment: .top, content:{
                if self.contact.information != nil {
                    UrlImageView(url: self.contact.information!.avatar.url)
                        .clipShape(Circle())
                        .frame(width: 50, height: 50)
                        .padding(.leading, self.spacing)
                } else {
                    Image("turtlerock")
                        .resizable()
                        .frame(width: 46, height: 46)
                        .clipShape(Circle())
                        .overlay(Circle()
                            .stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 4)
                        .padding(.leading, self.spacing)
                }

                VStack(alignment: .leading) {
                    Text(self.contact.firstName)
                        .foregroundColor(Color("Body"))
                        .font(.system(size: 28.0, weight: .bold, design: .rounded))
                    Text(self.contact.lastName)
                        .foregroundColor(Color("Body"))
                        .font(.system(size: 28.0, weight: .bold, design: .rounded))
                    Text(self.contact.descriptionField)
                        .foregroundColor(Color("Body"))
                        .font(.SFUIDisplayFontRegularSeventeen())
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                }.padding(.leading, 10)

                Spacer()

                Button(action: {
                    let contactFields = self.contact.contactFields?.map{$0.toContactFieldDto()}
                    self.showModal.modalViewModel = ContactMenuViewModel(contact: self.contact,
                                                                         contactFields: contactFields ?? [])
                }) {
                    Image(systemName: "ellipsis.circle")
                        .font(Font.title.weight(.regular))
                        .foregroundColor(Color.white)

                }.background(Color.blue)
                    .clipShape(Circle())
                    .padding(.trailing, self.spacing)
        })
    }
}
}

#if DEBUG
//struct ContactTitleCellView_Previews: PreviewProvider {
//    @State static var value:Contact? = nil
//    static var previews: some View {
//        ContactTitleCellView(viewModel: .init(contact: value))
//    }
//}
#endif
