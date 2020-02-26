//
//  ListContactsView.swift
//  Monica
//
//  Created by Julien Hamon on 2020-02-21.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftUI

struct ListContactsView<T>: View where T : Contactable {

    // MARK: Public Properties
    @ObservedObject var viewModel: ListContactsViewModel<T>

    var body: some View {
        List {
            ForEach(self.viewModel.searchListcontacts) { self.getContactCells(item: $0)
            }
        }.onAppear {
            self.viewModel.apply(.onAppear)
        }
    }

    // MARK: Private Functions
    private func getContactCells(item: Contact) -> some View {
        NavigationLink(destination: ContactDetailsView(viewModel: .init(id: item.id))) {
                           ContactCell(lastname: item.lastName,
                                       firstname: item.firstName,
                                       nickname: item.nickname,
                                       isFavorite: item.isStarred)
                       }
                       .padding(.vertical, 8.0)

    }

}

#if DEBUG
struct ListContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ListContactsView<ContactService>(viewModel: .init(id: nil))
    }
}
#endif
