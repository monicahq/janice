//
//  SwiftUIView.swift
//  Monica
//
//  Created by Julien Hamon on 2020-02-22.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftUI

struct ErrorView: View {
    let text: String
    var body: some View {
        VStack {
                Text(text)
                    .lineLimit(nil)

                Button(action: {
                    // do something
                }) {
                    Text("Retry")
                }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(text: "test")
    }
}
