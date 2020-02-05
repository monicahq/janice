//
//  UrlImageView.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-11.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct UrlImageView: View {
    let url: String
    
    var body: some View {
        AnimatedImage(url: URL(string: url),
                      options: [.progressiveLoad])
            .onFailure { error in
        }
        .resizable()
        .placeholder(UIImage(systemName: "photo"))
        .indicator(SDWebImageActivityIndicator.medium)
        .transition(.fade)
        .scaledToFill()
    }
}

#if DEBUG
struct UrlImageView_Previews: PreviewProvider {
    static var value = "https://monica-assets-s3.s3.amazonaws.com/avatars/bcd03dfa-97ab-41da-9177-2485090d1215.jpg?1574810227"
    static var previews: some View {
        UrlImageView(url: value)
    }
}
#endif
