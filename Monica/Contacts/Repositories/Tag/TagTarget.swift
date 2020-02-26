//
//  TagTarget.swift
//  Monica
//
//  Created by Julien Hamon on 2020-02-19.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import UIKit
import Moya

enum TagTarget {
    case getTags
    case getTagContacts(id: String)
}

extension TagTarget: TargetType {
    var baseURL: URL { return URL(string: "https://app.monicahq.com/api")! }
    var path: String {
        switch self {
        case .getTags:
            return "/tags/"
        case .getTagContacts (let id):
            return "/tags/\(id)/contacts"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getTags,.getTagContacts :
            return .get
        }
    }
    var task: Task {
        switch self {
        case .getTags, .getTagContacts :
            return .requestPlain
        }
    }

    var validationType: ValidationType {
        switch self {
        case .getTags, .getTagContacts :
            return .successCodes
        }
    }

    var sampleData: Data {
        switch self {
        case .getTags:
            guard let url = Bundle.main.url(forResource: "tags", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        case .getTagContacts(let id):
            guard let url = Bundle.main.url(forResource: "tagContacts\(id)", withExtension: "json"),
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
