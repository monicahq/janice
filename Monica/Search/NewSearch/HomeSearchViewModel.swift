//
//  HomeSearchViewModel.swift
//  Monica
//
//  Created by Julien Hamon on 2020-02-19.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class HomeSearchViewModel: ObservableObject ,UnidirectionalDataFlow {

    // MARK: Public Properties

    enum Input {
        case onAppear
    }

    @Published var listState: ListState<[String]>
    @Published var tagContactViewModel:  ListContactsViewModel<TagService>?
    @Published var tabChanged = 0

    // MARK: Private Properties

    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private var disposables = Set<AnyCancellable>()
    private let tagService = MonicaAssembler.sharedInstance.assembler.resolver.resolve(TagService.self)!
    private var tags = [Tag]()
    private var contactsTagsVM = [Int: ListContactsViewModel<TagService>]()

    // MARK: Init


    /// Default initializer.
    init() {
        listState = .loading
        getTags()

        $tabChanged
            .filter{ $0 > 0}
            .map {self.tags[$0-1] }
            .map { self.getOrCreateListContactVm(tagId: $0.id) }
            .assign(to: \.tagContactViewModel, on: self)
            .store(in: &disposables)

    }

    // MARK: Public Functions

    func apply(_ input: Input) {
        switch input {
        case .onAppear: onAppearSubject.send()
        }
    }

    // MARK: Private Functions

    private func getOrCreateListContactVm(tagId:Int) -> ListContactsViewModel<TagService> {
        if let listContactViewModel = contactsTagsVM[tagId] {
            return listContactViewModel
        }
        let listContactsVm = ListContactsViewModel<TagService>(id: tagId)
        contactsTagsVM[tagId] = listContactsVm
        return listContactsVm
    }

    private func getTags(){
        self.tagService
            .getTags()
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    //                    listState = .error()
                    self.listState = .items(data: [])
                case .finished:
                    break
                }
            }) {[weak self] tags in
                self?.tags = tags
                var string = ["All Contacts"]
                string.append(contentsOf: tags.map{$0.name})
                self?.listState = .items(data: string)
        }
        .store(in: &disposables)

    }
}
