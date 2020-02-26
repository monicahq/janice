//
//  PhotoService.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-13.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Foundation
import Combine

class PhotoService {

    // MARK: Private Properties

    private let photoApi = MonicaAssembler.sharedInstance.assembler.resolver.resolve(PhotoAPI.self)!

    // MARK: Public Functions

    func getPhotosForContact(contactId:String) -> AnyPublisher<[Photo], Never> {
        return photoApi
            .getPhotosForContact(contactId: contactId)
            .catch { error in
                Just<[Photo]>([])
            }
            .eraseToAnyPublisher()
    }

}
