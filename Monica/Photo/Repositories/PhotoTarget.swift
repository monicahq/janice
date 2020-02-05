//
//  PhotoTarget.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-13.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Moya

enum PhotoTarget {
    case getPhotos
    case getContactPhotos(id:String)
}

extension PhotoTarget: TargetType {
    var baseURL: URL { return URL(string: "https://app.monicahq.com/api")! }
    var path: String {
        switch self {
        case .getPhotos:
            return "/photos/"
        case .getContactPhotos(let id):
            return "/contacts/\(id)/photos/"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getPhotos,.getContactPhotos:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .getPhotos, .getContactPhotos:
            return .requestPlain
        }
    }

    var validationType: ValidationType {
        switch self {
        case .getPhotos, .getContactPhotos:
            return .successCodes
        }
    }

    var sampleData: Data {
        switch self {
        case .getPhotos:
            guard let url = Bundle.main.url(forResource: "photos", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        case .getContactPhotos:
            guard let url = Bundle.main.url(forResource: "contactPhotos", withExtension: "json"),
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
