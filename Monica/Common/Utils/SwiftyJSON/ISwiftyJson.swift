//
//  ISwiftyJson.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-02.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftyJSON

protocol SwiftyJson : Decodable{
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON)
}

extension JSON {
    enum ValidationError: Error {
        case dateError
    }

    public var dateValue: Date {
        get {
            return date ?? Date()
        }
    }

    public var date: Date? {
        get {
            if let str = self.string,
                let date = try? JSON.convertDate(dateString: str) {
                return date
            }
            return nil
        }
    }

    private static func convertDate (dateString: String) throws -> Date {
        for formatter in dateFormatters {
            if let date = formatter.date(from: dateString) {
                return date
            }
        }

        throw ValidationError.dateError
    }

    private static var dateFormatters: [DateFormatter] {
        get {
            return [ DateFormatter.standardTMilliseconds, DateFormatter.standardT ]
        }
    }
}
