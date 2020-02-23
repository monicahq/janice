//
//  ListContactsView.swift
//  Monica
//
//  Created by Julien Hamon on 2020-02-21.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftUI

struct ListContactsView<T>: View where T : Contactable {
    @ObservedObject var viewModel: ListContactsViewModel<T>

    var body: some View {
        List {
            ForEach(self.viewModel.searchListcontacts) { item in
                NavigationLink(destination: ContactDetailsView(viewModel: .init(id: item.id))) {
                    ContactCell(lastname: item.lastName,
                                firstname: item.firstName,
                                nickname: item.nickname,
                                isFavorite: item.isStarred)
                }
                .padding(.vertical, 8.0)
            }
        }.onAppear {
            self.viewModel.apply(.onAppear)
        }
    }
}

#if DEBUG
struct ListContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ListContactsView<ContactService>(viewModel: .init(id: nil))
    }
}
#endif
