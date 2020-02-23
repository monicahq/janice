//
//  SearchView.swift
//  Monica
//
//  Created by julien hamon on 2019-11-28.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel: ListContactsViewModel<ContactService>
    var searchController: SearchViewController<ListContactsView<ContactService>>
    
    init(viewModel:ListContactsViewModel<ContactService>) {
        self.viewModel = viewModel
        searchController = SearchViewController(content: {
            ListContactsView(viewModel: viewModel)
        })
        viewModel.apply(.searchText(text: searchController.publisher))
    }
    
    var body: some View {
        searchController
    }
}
#if DEBUG
struct SearchView_Previews: PreviewProvider {
    @State static var showing = false
    static var previews: some View {
        SearchView(viewModel: .init(id: nil))
    }
}
#endif
