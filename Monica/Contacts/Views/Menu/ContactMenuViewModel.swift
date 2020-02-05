//
//  ContactMenuViewModel.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-17.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Foundation
import Combine
import MessageUI
import SwiftUI

class ContactMenuViewModel: ObservableObject, UnidirectionalDataFlow {

    // MARK: Public Properties

    enum Input {
        case onAppear
    }

    func apply(_ input: Input) {
        switch input {
        case .onAppear: onAppearSubject.send(())
        }
    }

    @Published var completeName = ""
    @Published var imageURL = ""
    @Published var cellsMenu = [Int:[MenuCellData]]()

    // MARK: Private Properties

    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private var disposables = Set<AnyCancellable>()

    // MARK: Init

    init(contact:Contact?, contactFields: [ContactFieldDTO]) {

        onAppearSubject
            .sink { _ in
                self.completeName = contact?.completeName ?? ""
                self.imageURL = contact?.information?.avatar.url ?? ""
                self.cellsMenu = self.constructMenu(contact: contact,
                                                    contactFields: contactFields)
        }.store(in: &disposables)
    }

    private func constructMenu(contact:Contact?, contactFields: [ContactFieldDTO]) -> [Int: [MenuCellData]] {
        var cells = [Int:[MenuCellData]]()
        let firstname = contact?.firstName ?? ""
        let contactTel = contactFields.filter{$0.type == .tel}.first
        var row = [MenuCellData]()
        row.append(MenuCellData(id: 1, name:"Edit information about " + firstname, action: nil))
        row.append(MenuCellData(id: 2, name:"Share contact information...", action: nil))
        cells[0] = row
        row.removeAll()

        if let contactTel = contactTel {
            row.append(MenuCellData(id: 1, name:"Call " + firstname, action: { _ in
                contactTel.value.makeACall()
            }))
            row.append(MenuCellData(id: 2, name:"Send a message to " + firstname, action: nil))
        }

        row.append(MenuCellData(id: 3, name:"Open address in Maps", action: nil))
        cells[1] = row

        return cells

    }
}
