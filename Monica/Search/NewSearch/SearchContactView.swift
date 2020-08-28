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
    @State var isPresented = false

    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    HStack {
                        Image("panda")
                            .resizable()
                            .frame(width: 27, height: 27 )
                        SearchBar(text: $viewModel.searchText)
                    }
                    .padding(.leading, 17)
                    .background(Color("GrayBackground"))

                    searchResultView()
                        .background(Color.white)
                    Spacer()
                }
                .navigationBarHidden(isNavigationBarHidden)
                .onAppear {
                    self.isNavigationBarHidden = true
                }
                .onDisappear {
                    self.isNavigationBarHidden = false
                }
                .navigationBarTitle("")
            }

            addButton()
        }.modalLink(isPresented: $isPresented,
                    destination: {
                        AddContactFormView()
        })
    }

    // MARK: Private Functions
    private func addButton() -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        self.isPresented.toggle()
                    }                }, label: {
                        Text("+")
                            .font(.system(.largeTitle))
                            .frame(width: 77, height: 70)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 7)
                })
                    .background(Color.blue)
                    .cornerRadius(38.5)
                    .padding()
                    .shadow(color: Color.black.opacity(0.3),
                            radius: 3,
                            x: 3,
                            y: 3)
            }
        }
    }

    private func searchResultView() -> some View {
        switch viewModel.results {
        case .error(let error):
            if let searchError = error as? SearchContactViewModel.SearchContactError,
                searchError == .noSearch {
                return AnyView(HomeSearchView(viewModel: .init()))
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
