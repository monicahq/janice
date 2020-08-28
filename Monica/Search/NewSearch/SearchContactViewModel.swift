//
//  SearchContactViewModel.swift
//  Monica
//
//  Created by Julien Hamon on 2020-02-22.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Foundation
import Combine

class SearchContactViewModel: ObservableObject {

    // MARK: Public Properties

    @Published var searchText = ""
    @Published var results: ListState<ListContactsViewModel<ContactService>>
    
    enum SearchContactError : Error {
        case noSearch
        case unknowError
    }

    // MARK: Private Properties

    private let contactService = MonicaAssembler.sharedInstance.assembler.resolver.resolve(ContactService.self)!
    private var disposables = Set<AnyCancellable>()

    // MARK: Init

    /// Default Initializer.
    init() {
        results = ListState.error(SearchContactError.noSearch)

        $searchText
            .sink(receiveValue: {
                if $0.isEmpty {
                    self.results = .error(SearchContactError.noSearch)
                    return
                }
                self.results = ListState.items(data: ListContactsViewModel(id: $0))
            })
            .store(in: &disposables)
    }
}
