//
//  ListContactsViewModel.swift
//  Monica
//
//  Created by Julien Hamon on 2020-02-21.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Foundation
import Combine

class ListContactsViewModel<T>: ObservableObject, UnidirectionalDataFlow where T : Contactable {
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
    private let contactService = MonicaAssembler.sharedInstance.assembler.resolver.resolve(T.self)!
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

    init(id:Any?) {
        listState = .loading
        self.contactService.getContacts(params: id)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    //                    listState = .error()
                    self.searchListcontacts = []
                case .finished:
                    break
                }
            }) {[weak self] contacts in
                self?.listState = .items(data: contacts)
                self?.contacts = contacts
                self?.searchListcontacts = contacts
        }.store(in: &disposables)
        
        searchSubject
            .map {[weak self] text in
                self?.contacts.filter { text.isEmpty ? true : $0.firstName.localizedCaseInsensitiveContains(text) }
        }
        .sink(receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure:
                self.searchListcontacts = []
            case .finished:
                break
            }
        }) {[weak self] (contacts) in
            self?.searchListcontacts = contacts ?? []
        }.store(in: &disposables)
    }
}
