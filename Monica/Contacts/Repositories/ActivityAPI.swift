//
//  ActivityAPI.swift
//  Monica
//
//  Created by Julien Hamon on 2019-11-24.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Foundation
import Combine
import Alamofire
import Moya
import SwiftyJSON

class ActivityAPI {

    enum ActivityError: Error {
           case unknowError
       }

    // MARK: - Private Properties
    private let provider: MoyaProvider<MultiTarget>

    // MARK: - Init

    init(provider:MoyaProvider<MultiTarget>) {
        self.provider = provider
    }

    // MARK: - Public Functions

    func getActivities() -> Future<[Activity], Error> {
        return Future { promise in
            self.provider.request(MultiTarget(ActivityTarget.getActivities)) { result in
                switch result {
                case let .success(moyaResponse):
                    do {
                        let json = try JSON(data: moyaResponse.data)
                        let data = DatasModel<Activity>(fromJson: json)
                        promise(Swift.Result.success(data.data))

                    }
                    catch {
                        promise(.failure(ActivityError.unknowError))
                    }
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }

    func getContactActivities(id: String) -> Future<[Activity], Error> {
        return Future { promise in
            self.provider.request(MultiTarget(ActivityTarget.getContactActivities(id: id))) { result in
                switch result {
                case let .success(moyaResponse):
                    do {
                        let json = try JSON(data: moyaResponse.data)
                        let data = DatasModel<Activity>(fromJson: json)
                        promise(Swift.Result.success(data.data))

                    }
                    catch {
                        promise(.failure(ActivityError.unknowError))
                    }
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }

    func getReminders() -> Future<[Reminder], Error> {
        return Future { promise in
//            Alamofire.request("https://app.monicahq.com/api/reminders/",headers: headers)
//                .validate()
//                .responseDecodable(of: DataModel<Reminder>.self) { response in
//                    switch response.result {
//                    case .success (let list):
//                        promise(.success(list.data))
//                    case let .failure(error):
//                        promise(.failure(error))
//                    }
//            }
        }
    }

}
