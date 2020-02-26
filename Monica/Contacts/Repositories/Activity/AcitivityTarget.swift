//
//  AcitivityTarget.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-21.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Moya

enum ActivityTarget {
    case getActivities
    case getContactActivities(id: String)
    case getReminder
}

extension ActivityTarget: TargetType {
    var baseURL: URL { return URL(string: "https://app.monicahq.com/api")! }
    var path: String {
        switch self {
        case .getActivities:
            return "/activities/"
        case .getReminder:
            return "/reminders/"
        case .getContactActivities(let id):
            return "/contacts/\(id)/activities/"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getActivities,.getContactActivities,.getReminder:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .getActivities, .getContactActivities, .getReminder:
            return .requestPlain
        }
    }

    var validationType: ValidationType {
        switch self {
        case .getActivities, .getContactActivities, .getReminder:
            return .successCodes
        }
    }

    var sampleData: Data {
        switch self {
        case .getActivities:
            guard let url = Bundle.main.url(forResource: "activities", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        case .getContactActivities:
            guard let url = Bundle.main.url(forResource: "contactActivities", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        case .getReminder:
            guard let url = Bundle.main.url(forResource: "reminders", withExtension: "json"),
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
