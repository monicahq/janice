//
//  ContactDetailsViewModel.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-17.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Foundation
import Combine

class ContactDetailsViewModel: ObservableObject, UnidirectionalDataFlow {

    enum Input {
        case onAppear
        case getPhotos
    }

    func apply(_ input: Input) {
        switch input {
        case .onAppear : onAppearSubject.send()
        case .getPhotos : getPhotosSubject.send()

        }
    }

    @Published var contact:Contact?
    @Published var lastActivityDate:String = ""
    @Published var bornText:String = ""
    @Published var adress:Address?
    @Published var relationships = RelationshipsListViewModel(relationships: [:])
    @Published var listState: ListState<Contact>
    @Published var note = [Note]() //ListNotesViewModel = ListNotesViewModel(notes: [])
    @Published var photoCarrouselViewModel: PhotoCarrouselViewModel
    @Published var reminderListViewModel: ReminderListViewModel
    @Published var contactFields = [ContactFieldDTO]()

    // MARK: Private Properties
    private let contactService = MonicaAssembler.sharedInstance.assembler.resolver.resolve(ContactService.self)!
    private var disposables = Set<AnyCancellable>()
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private let getPhotosSubject = PassthroughSubject<Void, Never>()

    // MARK: Init

    /// Default initializer.
    /// - Parameter id: Contact id.
    init(id:Int) {
        listState = .loading
        photoCarrouselViewModel = PhotoCarrouselViewModel(id: id)
        reminderListViewModel = ReminderListViewModel(contactId: id)
        
        onAppearSubject
            .setFailureType(to: Error.self)
            .flatMap { _ in self.contactService.getContact(id: id.description ) }
            .sink(receiveCompletion: {[weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.contact = nil
                case .finished:
                    break
                }
            }) { contact in
                self.listState = .items(data: contact)

                if let activityDate = contact.lastActivityTogether {
                    self.lastActivityDate = self.transformDate(date: activityDate) ?? String.empty
                }

                if let bornText = contact.information?.getBirthdate() {
                    self.bornText = (self.transformDate(date: bornText) ?? String.empty) + String.space + "(\(bornText.getAge().description))"
                }

                if let adress = contact.addresses.first {
                    self.adress = adress
                }
                if let relationships = contact.information?.relationships {
                    self.relationships = RelationshipsListViewModel(relationships: relationships)
                }
                if let notes = contact.notes {
                    self.note = notes
                }
                self.contactFields = self.convertContactField(contactFields: contact.contactFields ?? [])
                self.contact = contact
        }.store(in: &disposables)
    }


    // MARK: Private Functions

    private func convertContactField(contactFields:[ContactField]) -> [ContactFieldDTO] {
        return contactFields.map { $0.toContactFieldDto() }
    }

    private func getContactNotes(contactId: Int) {
        getPhotosSubject
            .setFailureType(to: Error.self)
            .flatMap{ self.contactService.getNotesForContact(contactId: contactId.description) }
            .sink(receiveCompletion: { [weak self] value in
                 guard let self = self else { return }
                               switch value {
                               case .failure:
                                   self.note = []
                               case .finished:
                                   break
                               }
            }) { notes in
                self.note = notes //ListNotesViewModel(notes: notes)
        }.store(in: &disposables)
    }

    private func transformDate(date:Date)-> String? {
        let dateFormatter = DateFormatter.standardMonth
        return dateFormatter.string(from: date).description
    }
}
