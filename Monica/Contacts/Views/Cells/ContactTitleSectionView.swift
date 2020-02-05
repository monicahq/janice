//
//  ContactTitleSectionView.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-22.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftUI

struct ContactTitleSectionView: View {
    let title: String
    var count: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color("Body"))
                .font(.system(size: 20.0, weight: .regular, design: .rounded))
            
            Text(count)
                .foregroundColor(Color("Gray"))
                .font(.system(size: 12.0, weight: .regular, design: .rounded))

            Spacer()

            Text("More")
                .foregroundColor(Color("Link"))
                .font(.system(size: 12, weight: .regular, design: .rounded))
        }
        .padding(.horizontal, 15)
        .padding(.top, 20)    }
}

#if DEBUG
struct ContactTitleSectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ContactTitleSectionView(title: "My Title", count: "1")
            ContactTitleSectionView(title: "My Title", count: "")

        }
    }
}
#endif

