//
//  ContactListViewModel.swift
//  Monica
//
//  Created by Julien Hamon on 2019-11-23.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import SwiftUI
import Combine

class ContactListViewModel: ObservableObject, UnidirectionalDataFlow {

    enum Input {
        case onAppear
        case remove(index:IndexSet)

    }
    
    func apply(_ input: Input) {
        switch input {
        case .onAppear: onAppearSubject.send(())
        case .remove(let index): deleteSubject.send(index)
        }
    }

    @Published var contacts:[Contact] = []

    // MARK: Private Properties
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private let deleteSubject = PassthroughSubject<IndexSet, Never>()

    private var disposables = Set<AnyCancellable>()
    private let contactAPI = MonicaAssembler.sharedInstance.assembler.resolver.resolve(ContactService.self)!

    // MARK: Init
    init() {
        onAppearSubject
            .setFailureType(to: Error.self)
            .flatMap { self.contactAPI.getContacts(params: nil)}
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.contacts = []
                case .finished:
                    break
                }
            }) { (contacts) in
                self.contacts = contacts
        }.store(in: &disposables)

        deleteSubject
            .map{self.contacts[$0.first!]}
            .flatMap{self.contactAPI.deleteContact(id: $0.id.description)}
            .sink(receiveCompletion: { value in
                switch value {
                case .failure:
                    break
                case .finished:
                    break
                }
            }) { isDeleted in
                print(isDeleted)
        }.store(in: &disposables)
    }
}
