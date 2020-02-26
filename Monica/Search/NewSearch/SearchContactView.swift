//
//  SearchContactView.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-31.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftUI

struct SearchContactView: View {

    // MARK: Public Properties

    @ObservedObject var viewModel: SearchContactViewModel

    // MARK: Private Properties

    @State private var isNavigationBarHidden = true
    private var homeSearchView: HomeSearchView = HomeSearchView(viewModel: .init())

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                searchResultView()
                Spacer()
            }
            .navigationBarHidden(isNavigationBarHidden)
            .navigationBarTitle("")
            .onAppear {
                self.isNavigationBarHidden = true
            }
            .onDisappear {
                self.isNavigationBarHidden = false
            }
            .edgesIgnoringSafeArea([.top])
        }
    }
    
    init(viewModel: SearchContactViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Private Functions

    private func searchResultView() -> some View {
        switch viewModel.results {
        case .error(let error):
            if let searchError = error as? SearchContactViewModel.SearchContactError,
                searchError == .noSearch {
                return AnyView(homeSearchView)
            }
            return AnyView(ErrorView(text: error.localizedDescription))
        case .items(let viewModel):
            return AnyView(
                ListContactsView<ContactService>(viewModel: viewModel)
            )
        case .loading:
            return AnyView(
                VStack(alignment: .center) {
                    LottieView(filename: "pulse-loader")
                }
            )
        }
    }
}

#if DEBUG
struct SearchContactView_Previews: PreviewProvider {
    static var previews: some View {
        SearchContactView(viewModel: .init())
    }
}
#endif
