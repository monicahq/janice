//
//  SearchView.swift
//  Monica
//
//  Created by julien hamon on 2019-11-28.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel: SearchViewModel
    var searchController: SearchViewController<ContactSearchView>
    
    init(viewModel:SearchViewModel) {
        self.viewModel = viewModel
        searchController = SearchViewController(content: {
            ContactSearchView(viewModel: viewModel)
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
        SearchView(viewModel: .init())
    }
}
#endif


struct ContactSearchView: View {
    
    @ObservedObject var viewModel: SearchViewModel

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
