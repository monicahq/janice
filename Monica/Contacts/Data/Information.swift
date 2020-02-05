//
//  Information.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-18.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Information: SwiftyJson {

    let dates:[String:DateInformation]
    let relationships : [String: Relationships]
    var avatar : Avatar

    init(fromJson json: JSON) {
        let datesJson = json["dates"]
        var datesCust = [String: DateInformation]()
        for (key,subJson):(String, JSON) in datesJson {
            datesCust[key] = DateInformation(fromJson: subJson)
        }
        dates = datesCust
        
        var relationshipsCust = [String: Relationships]()
        for (key, subJson):(String, JSON) in json["relationships"] {
            relationshipsCust[key] = Relationships(fromJson: subJson)
        }
        relationships = relationshipsCust
        avatar = Avatar(fromJson: json["avatar"])

    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        dictionary["relationships"] = relationships
        return dictionary
    }

}
