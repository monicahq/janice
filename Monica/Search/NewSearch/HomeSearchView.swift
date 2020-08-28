//
//  TabSlidingView.swift
//  Monica
//
//  Created by Julien Hamon on 2020-02-19.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftUI

struct HomeSearchView: View {

    // MARK: Public Properties

    @ObservedObject var viewModel: HomeSearchViewModel

    var body: some View {
        switch viewModel.listState {
        case .error(let error):
            return AnyView(
                ErrorView(text: error.localizedDescription)
            )
        case .items(let tags):
            if !tags.isEmpty {
                return AnyView(
                    getPagerStripView(tags: tags)
                )
            } else {
                return AnyView(                    EmptyContactDetailsView()
                )
            }
        case .loading:
            return AnyView(
                VStack(alignment: .center) {
                    LottieView(filename: "pulse-loader")
                }
            )
        }
    }

    private let contactView = ListContactsView<ContactService>(viewModel: .init(id: nil))

    // MARK: Private Functions

    private func getPagerStripView(tags:[String]) -> some View {
        VStack(alignment: .leading) {
            Group{
                Text("contact_title")
                    .font(.SFUIDisplayFontBoldTitle())
                    .foregroundColor(Color("Body"))
            }
            .padding(.horizontal, 15)
             Divider()
                                   .frame(height: 1)
                                   .background(Color("GrayBackground"))
            
            PagerStripView(selection: self.$viewModel.tabChanged,
                           tabs: tags,
                           font: .SFUIDisplayFontRegularSeventeen(),
                           activeAccentColor: Color.black,
                           inactiveAccentColor: Color("Gray"),
                           selectionBarColor: Color.red )
            if self.viewModel.tabChanged == 0 {
               contactView
            }
            else {
                self.viewModel
                    .tagContactViewModel
                    .map{ListContactsView<TagService>(viewModel: $0) }
            }
            Spacer()
        }
        .animation(.none)
    }
}

#if DEBUG
struct HomeSearchView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSearchView(viewModel: .init())
    }
}
#endif
