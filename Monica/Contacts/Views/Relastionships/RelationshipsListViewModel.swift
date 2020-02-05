//
//  RelationshipsListViewModel.swift
//  Monica
//
//  Created by Julien Hamon on 2020-02-04.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Combine

class RelationshipsListViewModel: ObservableObject {

    // MARK: Public Properties

    /// Publishes relationships
    @Published var relationships:[[Relationship]] = []
    @Published var number = ""

    // MARK: Private Properties

    private let onAppearSubject = PassthroughSubject<Void, Never>()

    // MARK: Init

    /// Default Initilizer with Relationships
    /// - Parameter relationships: List of Relationships.
    init(relationships:[String: Relationships]) {
        var number = 0
        self.relationships = relationships.compactMap({ values -> [Relationship]? in
            let relationship = values.value.relationship
            let nbRelation = relationship.count
            number = number + nbRelation
            return nbRelation > 0 ? relationship : nil
        })
        self.number = number.description
    }
}
