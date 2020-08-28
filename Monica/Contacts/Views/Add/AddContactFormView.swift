//
//  AddContactForm.swift
//  Monica
//
//  Created by Julien Hamon on 2020-04-22.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftUI

struct AddContactFormView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("I've been presented")
                Spacer()
            }
            NavigationLink(destination: Text("Pushed")) {
                Text("Tap to push")
            }
        }
        .padding(.horizontal)
    }
}

struct AddContactFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactFormView()
    }
}
