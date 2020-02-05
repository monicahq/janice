//
//  ContactFieldType.swift
//  Monica
//
//  Created by Julien Hamon on 2020-02-01.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Foundation
import SwiftyJSON


struct ContactFieldType : Decodable {

    var createdAt : String
    var delible : Bool
    var fontawesomeIcon : String
    var id : Int
    var name : String
    var object : String
    var protocolType : String
    var type : String
    var updatedAt : String

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            assertionFailure("No JSON")
        }
        createdAt = json["created_at"].stringValue
        delible = json["delible"].boolValue
        fontawesomeIcon = json["fontawesome_icon"].stringValue
        id = json["id"].intValue
        name = json["name"].stringValue
        object = json["object"].stringValue
        protocolType = json["protocol"].stringValue
        type = json["type"].stringValue
        updatedAt = json["updated_at"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        dictionary["created_at"] = createdAt
        dictionary["delible"] = delible
        dictionary["fontawesome_icon"] = fontawesomeIcon
        dictionary["id"] = id
        dictionary["name"] = name
        dictionary["object"] = object
        dictionary["protocol"] = protocolType
        dictionary["type"] = type
        dictionary["updated_at"] = updatedAt

        return dictionary
    }
}

