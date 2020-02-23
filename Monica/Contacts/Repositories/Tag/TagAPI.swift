//
//  TagAPI.swift
//  Monica
//
//  Created by Julien Hamon on 2020-02-19.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Foundation
import Moya
import Combine
import SwiftyJSON

class TagAPI {

    enum TagError: Error {
        case unknowError
    }
    // MARK: - Private Properties
    private let provider: MoyaProvider<MultiTarget>

    // MARK: - Init

    init(provider:MoyaProvider<MultiTarget>) {
        self.provider = provider
    }

    // MARK: - Public Functions

    func getTags() -> Future<[Tag], Error> {
        return Future { promise in
            self.provider.request(MultiTarget(TagTarget.getTags)) { result in
                switch result {
                case let .success(moyaResponse):
                    do {
                        let json = try JSON(data: moyaResponse.data)
                        let data = DatasModel<Tag>(fromJson: json)
                        promise(Swift.Result.success(data.data))

                    }
                    catch {
                        promise(.failure(TagError.unknowError))
                    }
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }

    func getTagContacts(id: String) -> Future<[Contact], Error> {
        return Future { promise in
            self.provider.request(MultiTarget(TagTarget.getTagContacts(id: id))) { result in
                switch result {
                case let .success(moyaResponse):
                    do {
                        let json = try JSON(data: moyaResponse.data)
                        let data = DatasModel<Contact>(fromJson: json)
                        promise(Swift.Result.success(data.data))

                    }
                    catch {
                        promise(.failure(TagError.unknowError))
                    }
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }
}
