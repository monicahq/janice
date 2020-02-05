//
//  ListNotesViewModel.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-22.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Foundation
import Combine

class ListNotesViewModel: ObservableObject, UnidirectionalDataFlow {

    // MARK: Public Properties

    enum Input {
        case onAppear
    }

    var notes = [Note]()

    // MARK: Private Properties
    private let onAppearSubject = PassthroughSubject<Void, Never>()

    // MARK: Init

    /// Default initializer.
    /// - Parameter contactId: Contact id.
    init(notes:[Note]) {
        self.notes = notes
    }

    // MARK: Public Functions

    func apply(_ input: Input) {
        switch input {
        case .onAppear : onAppearSubject.send()
        }
    }
}
