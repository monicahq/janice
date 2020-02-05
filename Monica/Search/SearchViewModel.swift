//
//  SearchViewModel.swift
//  Monica
//
//  Created by julien hamon on 2019-11-29.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

class SearchViewModel: ObservableObject ,UnidirectionalDataFlow {

    // MARK: Public Properties

    enum Input {
        case onAppear
        case searchText(text: AnyPublisher<String, Never>)
    }
    
    @Published var searchListcontacts:[Contact] = []
    @Published var listState: ListState<[Contact]>

    // MARK: Private Properties

    private let searchSubject = PassthroughSubject<String, Never>()
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private let contactService = MonicaAssembler.sharedInstance.assembler.resolver.resolve(ContactService.self)!
    private var disposables = Set<AnyCancellable>()
    private var contacts:[Contact] = []
    
    func apply(_ input: Input) {
        switch input {
        case .onAppear: onAppearSubject.send(())
        case .searchText(let text): text.sink { text in
            self.searchSubject.send(text)
        }.store(in: &disposables)
        }
    }
    
    // MARK: Init

    init() {
        listState = .loading
        onAppearSubject
            .flatMap { _ in self.contactService.getAllContacts()}
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
//                    listState = .error()
                    self.searchListcontacts = []
                case .finished:
                    break
                }
            }) { contacts in
                self.listState = .items(data: contacts)
                self.contacts = contacts
                self.searchListcontacts = contacts
        }.store(in: &disposables)
        
        searchSubject
        .map { text in
            self.contacts.filter { text.isEmpty ? true : $0.firstName.localizedCaseInsensitiveContains(text) }
        }
        .sink(receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure:
                self.searchListcontacts = []
            case .finished:
                break
            }
        }) { (contacts) in
            self.searchListcontacts = contacts
        }.store(in: &disposables)
    }
    
}
