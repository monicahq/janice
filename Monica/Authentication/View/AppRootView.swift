//
//  AppRootView.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-09.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import SwiftUI

struct AppRootView: View {

    @ObservedObject var viewModel: AppRootViewModel

    var body: some View {
        Group {
            if viewModel.isConnected {
                HomeView()
            } else {
                SigninView()
            }
        }
    }
}

#if DEBUG
struct AppRootView_Previews: PreviewProvider {
    static var previews: some View {
        AppRootView(viewModel: .init())
    }
}
#endif
