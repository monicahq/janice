//
//  SwiftUIView.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-06.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftUI

struct RelationshipsView: View {

    // MARK: Public Properties

    @ObservedObject var viewModel: RelationshipsListViewModel

    var body: some View {
        GeometryReader { reader in

            VStack(alignment: .leading) {
                ContactTitleSectionView(title: "Relationships",
                                        count: self.viewModel.number)
                PageView(self.viewModel.relationships.map { self.getViews(relationships: $0) })

            }
            .background(Color.white)
        }
    }

    // MARK: Private Functions

    private func getViews(relationships:[Relationship]) -> some View {
        GeometryReader { reader in
            VStack(alignment: .leading) {
                ForEach(relationships, id: \.id) { relationship in
                    ContactRelationshipCellView(relationship: relationship)
                }
            }
            .padding(.leading, 15)
            .frame(width: reader.size.width, height: reader.size.height, alignment: .topLeading)
        }
    }
}

