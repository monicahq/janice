//
//  ReminderListeView.swift
//  Monica
//
//  Created by Julien Hamon on 2020-02-02.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftUI

struct ReminderListeView: View {
    @ObservedObject var viewModel: ReminderListViewModel

    var body: some View {
        VStack(alignment: .leading, content:{
            ContactTitleSectionView(title: "Important dates",
                                    count: "")

            ForEach(viewModel.reminders, id: \.id) { reminder in
                VStack(alignment: .leading) {
                    HStack(alignment: .firstTextBaseline) {
                        Text("July 19, 2019")
                            .foregroundColor(Color("Gray"))
                            .font(.system(size: 12.0, weight: .regular, design: .rounded))
                        Text(reminder.title)
                            .foregroundColor(Color("Body"))
                            .font(.system(size: 17.0, weight: .regular, design: .rounded))
                            .lineLimit(2)
                    }
                    .padding(.top, 12)

                    Divider()
                        .frame(height: 1)
                        .background(Color("GrayBackground"))
                }
                .padding(.horizontal, 15)

            }
        }).background(Color.white)
            .onAppear(perform: {self.viewModel.apply(.onAppear)})
    }
}

#if DEBUG
struct ReminderListeView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderListeView(viewModel: .init(contactId: 0))
    }
}
#endif
