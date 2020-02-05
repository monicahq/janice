//
//  PhotoCarrouselView.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-13.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftUI

struct PhotoCarrouselView: View {

    @ObservedObject var viewModel: PhotoCarrouselViewModel

    var body: some View {

        VStack{
            ContactTitleSectionView(title: "Photos",
                                    count: viewModel.photos.count.description)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(viewModel.photos) { item in
                        Button(action: { print(item.link)}) {
                            UrlImageView(url: item.link)
                            .cornerRadius(6)
                            .frame(width: 70, height: 70)
                                .padding(.leading, 15)
                        }
                    }
                }
            }
            .padding(.bottom, 20.0)
        }
        .background(Color.white)
        .onAppear(perform:{ self.viewModel.apply(.onAppear)})

    }
}

#if DEBUG
struct PhotoCarrouselView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCarrouselView(viewModel: .init(id: 0))
    }
}
#endif
