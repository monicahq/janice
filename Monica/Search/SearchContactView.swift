//
//  SearchContactView.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-31.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftUI

struct SearchContactView: View {

    @State private var searchText: String = ""
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                List {
                    Text("Test")
                }.navigationBarTitle("Welcome", displayMode: .inline)
            }

        }
    }
}

struct SearchContactView_Previews: PreviewProvider {
    static var previews: some View {
        SearchContactView(viewModel: .init())
    }
}
