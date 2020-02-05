//
//  ActivitesView.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-22.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftUI

struct ActivitiesView: View {
    @ObservedObject var viewModel: ActivitiesViewModel

    var body: some View {
        VStack(alignment: .leading, content:{
            ContactTitleSectionView(title: "Activities",
                                    count: "")
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(self.viewModel.activities, id: \.id) { activity in
                        Text(activity.description)
                    }
                }
                .padding(.leading, 10)
                .padding(.bottom, 20)
            }

        }).background(Color.white)
            .onAppear(perform: {self.viewModel.apply(.onAppear)})
    }
}

#if DEBUG
struct ActivitesView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesView(viewModel: .init(idContact: 0))
    }
}
#endif
