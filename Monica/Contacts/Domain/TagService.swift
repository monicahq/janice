//
//  TagService.swift
//  Monica
//
//  Created by Julien Hamon on 2020-02-19.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Foundation
import Combine

class TagService: Contactable {

    private let tagApi = MonicaAssembler.sharedInstance.assembler.resolver.resolve(TagAPI.self)!

    func getTags() -> AnyPublisher<[Tag], Never> {
        return tagApi
            .getTags()
            .catch { error in
                Just<[Tag]>([])
            }
            .eraseToAnyPublisher()
    }

    func getContacts(params: Any?) -> AnyPublisher<[Contact], Error> {
        guard let id = params as? Int else {
            assertionFailure("No id for contact id.")
            return Just([Contact]())
                .tryMap { _ in throw TagAPI.TagError.unknowError }
                .eraseToAnyPublisher()
        }
        return tagApi
            .getTagContacts(id: id.description)
           .eraseToAnyPublisher()
    }
}
