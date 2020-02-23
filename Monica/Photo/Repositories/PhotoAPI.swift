//
//  PhotoAPI.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-13.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Foundation
import Moya
import Combine
import SwiftyJSON

enum PhotoError: Error {
    case unknownError
}

class PhotoAPI {

    // MARK: Private Properties

    private let provider: MoyaProvider<MultiTarget>

    // MARK: Init


    /// Default Initializer.
    /// - Parameter provider: Moya API Provider.
    init(provider:MoyaProvider<MultiTarget>) {
        self.provider = provider
    }

    // MARK: Public Functions

    func getPhotosForContact(contactId:String) -> Future<[Photo], Error> {
        return Future { promise in
            self.provider.request(MultiTarget(PhotoTarget.getContactPhotos(id: contactId))) { result in
                switch result {
                case let .success(moyaResponse):
                    do {
                        let json = try JSON(data: moyaResponse.data)
                        let data = DatasModel<Photo>(fromJson: json)
                        promise(Swift.Result.success(data.data))

                    }
                    catch {
                        promise(.failure(PhotoError.unknownError))
                    }
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }
}
