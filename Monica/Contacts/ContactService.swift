//
//  ContactService.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-12.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Foundation
import Combine
import Moya

class ContactService {

    private let contactApi = MonicaAssembler.sharedInstance.assembler.resolver.resolve(ContactAPI.self)!

    func getAllContacts() -> AnyPublisher<[Contact], Never> {
        return contactApi
            .getContacts()
            .map{ $0.sorted(by: {
                if $0.lastName.lowercased() != $1.lastName.lowercased() {
                    return $0.lastName.lowercased() < $1.lastName.lowercased()
                }
                else {
                    return $0.firstName.lowercased() < $1.firstName.lowercased()
                }
            }) }
            .catch { error in
                Just<[Contact]>([])
            }
            .eraseToAnyPublisher()
    }

    func getNotesForContact(contactId: String) -> AnyPublisher<[Note], Error> {
        return contactApi
            .getNotesForContact(idContact: contactId)
            .eraseToAnyPublisher()
    }

    func getContact(id: String) -> AnyPublisher<Contact, Error> {
        return contactApi
            .getContact(id: id)
            .eraseToAnyPublisher()
    }

    func getContactReminders(id: String) -> AnyPublisher<[Reminder], Error> {
        return contactApi
            .getRemindersForContact(idContact: id)
            .eraseToAnyPublisher()
    }

    func deleteContact(id: String) -> AnyPublisher<Bool, Never> {
        return contactApi
            .deleteContacts(id: id)
            .catch { error in
                Just<Bool>(false)
            }
            .eraseToAnyPublisher()
    }

}
