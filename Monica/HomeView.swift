//
//  HomeView.swift
//  Monica
//
//  Created by Julien Hamon on 2019-11-23.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var showModal: ShowModal

    var body: some View {
        ZStack {
            TabView {
                DashboardView(viewModel: .init())
                    .tabItem {
                        Image("dashboard")
                        Text("Dashboard")
                }.tag(0)
                StickyHeader()
                    .tabItem {
                        Image("contacts")
                        Text("Contacts")
                }.tag(1)
                SearchContactView(viewModel: .init())
                    .tabItem {
                        Image("peoples_icon")
                        Text("Search")
                }.tag(2)
            }

            if showModal.modalViewModel != nil {
                ContactMenuUIView(viewModel: showModal.modalViewModel!)
            }
        }

    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
#endif

class ShowModal: ObservableObject {
    @Published var modalViewModel:ContactMenuViewModel? = nil

}
