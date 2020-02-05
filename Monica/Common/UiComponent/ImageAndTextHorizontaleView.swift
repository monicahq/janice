//
//  ImageAndTextHorizontaleView.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-16.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import SwiftUI

struct ImageAndTextHorizontaleView: View {
    var text: String
    var imageName: String

    var body: some View {
        HStack(alignment: .center){
            Image(imageName)
                .resizable()
                .font(Font.title.weight(.light))
                .foregroundColor(Color("Body"))
                .scaledToFit()
                .frame( width: 11, height: 11)

            Text(text)
                    .foregroundColor(Color("Body"))
                    .font(.system(size: 12,
                                  weight: .regular,
                                  design: .rounded))
        }    }
}

#if DEBUG
struct ImageAndTextHorizontaleView_Previews: PreviewProvider {
    static var previews: some View {
        ImageAndTextHorizontaleView(text: "test",
                                    imageName: "mobile")
    }
}
#endif
