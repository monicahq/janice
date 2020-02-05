//
//  DateInformation.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-18.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Foundation
import SwiftyJSON

struct DateInformation: SwiftyJson {
    let date: Date?
    let isAgeBased : Bool
    let isYearUnknown : Bool

    init(fromJson json: JSON){
        if json.isEmpty{
            assertionFailure("No Json")
        }
        date = json["date"].date
        isAgeBased = json["is_age_based"].boolValue
        isYearUnknown = json["is_year_unknown"].boolValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        dictionary["date"] = date
        dictionary["is_age_based"] = isAgeBased
        dictionary["is_year_unknown"] = isYearUnknown
        return dictionary
    }
}
