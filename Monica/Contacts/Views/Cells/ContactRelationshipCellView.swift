//
//  ContactRelationshipCellView.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-08.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContactRelationshipCellView: View {
    let relationship:Relationship
    
    var body: some View {
        HStack {
            UrlImageView(url: "https://monica-assets-s3.s3.amazonaws.com/avatars/bd939854-5d84-439b-8eb5-991891cbcb5c.jpg?1576625203")
            .clipShape(Circle())
            .frame(width: 21, height: 21)

            Text(relationship.contact.firstName)
                .foregroundColor(Color("Body"))
                .font(.system(size: 17, weight: .regular, design: .rounded))

            Text(relationship.name.rawValue)
                .foregroundColor(Color("Gray"))
                .font(.system(size: 12, weight: .regular, design: .rounded))
        }
    }
}

#if DEBUG
struct ContactRelationshipCellView_Previews: PreviewProvider {
    static let value = Relationship(name: .spouse, id: 0)

    static var previews: some View {
        ContactRelationshipCellView(relationship: value)
    }
}
#endif
