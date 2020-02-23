//
//  ContactAPI.swift
//  Monica
//
//  Created by julien hamon on 2019-11-20.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Foundation
import Moya
import Combine
import SwiftyJSON

class ContactAPI {

    enum ContactError: Error {
        case canNotDelete
        case unknowError
    }

    private let provider: MoyaProvider<MultiTarget>

    init(provider:MoyaProvider<MultiTarget>) {
        self.provider = provider
    }

    func getContacts(query:String? = nil) -> Future<[Contact], Error> {
        return Future { promise in
            self.provider.request(MultiTarget(MonicaAPI.getContacts(query: query))) { result in
                switch result {
                case let .success(moyaResponse):
                    do {
                        let json = try JSON(data: moyaResponse.data)
                        let data = DatasModel<Contact>(fromJson: json)
                        promise(Swift.Result.success(data.data))

                    }
                    catch {
                        promise(.failure(ContactError.canNotDelete))
                    }
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }

    func getNotesForContact(idContact: String) -> Future<[Note], Error> {
        return Future { promise in
            self.provider.request(MultiTarget(MonicaAPI.getContactNotes(id: idContact))) { result in
                switch result {
                case let .success(moyaResponse):
                    do {
                        let json = try JSON(data: moyaResponse.data)
                        let data = DatasModel<Note>(fromJson: json)
                        promise(Swift.Result.success(data.data))

                    }
                    catch {
                        promise(.failure(ContactError.unknowError))
                    }
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }

    func getRemindersForContact(idContact: String) -> Future<[Reminder], Error> {
        return Future { promise in
            self.provider.request(MultiTarget(MonicaAPI.getContactReminders(id: idContact))) { result in
                switch result {
                case let .success(moyaResponse):
                    do {
                        let json = try JSON(data: moyaResponse.data)
                        let data = DatasModel<Reminder>(fromJson: json)
                        promise(Swift.Result.success(data.data))
                    }
                    catch {
                        promise(.failure(ContactError.unknowError))
                    }
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }

    func getContact(id: String) -> Future<Contact, Error> {
            return Future { promise in
                self.provider.request(MultiTarget(MonicaAPI.getContact(id: id))) { result in
                    switch result {
                    case let .success(moyaResponse):
                        do {
                            let json = try JSON(data: moyaResponse.data)
                            let data = DataModel<Contact>(fromJson: json)
                            promise(Swift.Result.success(data.data))
                        }
                        catch {
                            promise(.failure(ContactError.canNotDelete))
                        }
                    case let .failure(error):
                        promise(.failure(error))
                    }
                }
            }
        }

    func deleteContacts(id:String) -> Future<Bool, Error> {
        return Future { promise in
            self.provider.request(MultiTarget(MonicaAPI.deleteContact(id: id))) { result in
                switch result {
                case let .success(moyaResponse):
                        guard let deleted = try? moyaResponse.mapJSON() as? [String:Any],
                            let bool = deleted["deleted"] as? Bool,
                            bool else {
                            promise(.failure(ContactError.canNotDelete))
                            return
                        }

                        promise(.success(true))
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
    }
}
