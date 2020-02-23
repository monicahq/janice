//
//  MonicaAPI.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-12.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Moya

enum MonicaAPI {
    case getContacts(query: String?)
    case getContact(id:String)
    case getContactNotes(id:String)
    case deleteContact(id:String)
    case getContactReminders(id:String)
}

extension MonicaAPI: TargetType {
    var baseURL: URL { return URL(string: "https://app.monicahq.com/api")! }
    var path: String {
        switch self {
        case .getContacts:
            return "/contacts/"
        case .getContactNotes(let id):
            return "/contacts/\(id)/notes"
        case .getContactReminders(let id):
            return "/contacts/\(id)/reminders"
        case .getContact(let id):
            return "/contacts/\(id)"
        case .deleteContact(let id):
            return "/contacts/\(id)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getContacts,.getContact, .getContactNotes, .getContactReminders :
            return .get
        case .deleteContact:
            return .delete
        }
    }
    var task: Task {
        switch self {
        case .deleteContact, .getContactNotes, .getContactReminders:
            return .requestPlain
        case .getContact:
            var params: [String: Any] = [:]
            params["with"] = "contactfields"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getContacts(let query):
            var params: [String: Any] = [:]
            if let query = query {
                params["query"] = query
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
        
    }

    var validationType: ValidationType {
        switch self {
        case .getContacts, .deleteContact,.getContact, .getContactNotes,. getContactReminders:
            return .successCodes
        }
    }

    var sampleData: Data {
        switch self {
        case .getContacts, .getContact:
            guard let url = Bundle.main.url(forResource: "contacts", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        case .getContactNotes:
            guard let url = Bundle.main.url(forResource: "contactNotes", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        case .getContactReminders:
            guard let url = Bundle.main.url(forResource: "contactReminders", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        case .deleteContact:
            guard let url = Bundle.main.url(forResource: "delete", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        }
    }
    var headers: [String: String]? {
        return [:]
    }
}

struct AuthPlugin: PluginType {
  let authentiationService: AuthenticationService

  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    var request = request
    request.addValue("Bearer " + authentiationService.getToken(), forHTTPHeaderField: "Authorization")
    return request
  }
}
