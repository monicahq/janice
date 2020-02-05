//
//  ReminderListView.swift
//  Monica
//
//  Created by Julien Hamon on 2020-02-02.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Foundation
import Combine

class ReminderListViewModel: ObservableObject, UnidirectionalDataFlow {
    
    // MARK: Pulic Properties
    
    enum Input {
        case onAppear
    }

    /// Publishes all the reminders.
    @Published var reminders:[Reminder] = []


    // MARK: Private Properties
    private let contactService = MonicaAssembler.sharedInstance.assembler.resolver.resolve(ContactService.self)!
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private var disposables = Set<AnyCancellable>()

    // MARK: Init

    /// Default Initializer.
    /// - Parameter contactId: Id of contact.
    init(contactId: Int) {
        onAppearSubject
            .setFailureType(to: Error.self)
            .flatMap { self.contactService.getContactReminders(id: String(contactId))}
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.reminders = []
                case .finished:
                    break
                }
            }) {
                self.reminders = $0
        }
        .store(in: &disposables)
    }

    // MARK: Public func
    func apply(_ input: Input) {
        switch input {
        case .onAppear : onAppearSubject.send()
        }
    }
}
