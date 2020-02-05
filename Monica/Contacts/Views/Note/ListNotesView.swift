//
//  SwiftUIView.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-22.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftUI

struct ListNotesView: View {

    @Binding var notes: [Note]

    var body: some View {
        VStack(alignment: .leading, content:{
                ContactTitleSectionView(title: "Notes",
                                        count: notes.count.description)

                ForEach(notes, id: \.id) { note in
                    VStack(alignment: .leading) {
                        Text(note.body)
                            .foregroundColor(Color("Body"))
                            .font(.system(size: 17.0, weight: .regular, design: .rounded))
                            .padding(.bottom, 3)
                        Text("July 19, 2019")
                            .foregroundColor(Color("Gray"))
                            .font(.system(size: 12.0, weight: .regular, design: .rounded))
                            .padding(.bottom, 15)
                        Divider()
                            .frame(height: 1)
                            .background(Color("GrayBackground"))
                    }
                    .padding(.horizontal, 15)
                    .padding(.top, 10)

                }
        }).background(Color.white)
    }
}

struct ListNotesView_Previews: PreviewProvider {
    @State static var viewModel = ListNotesViewModel(notes: [])
    @State static var notes = [Note]()
    static var previews: some View {
        ListNotesView(notes: $notes)
    }
}
