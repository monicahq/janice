//
//  Tag.swift
//  Monica
//
//  Created by Julien Hamon on 2020-02-19.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftyJSON

struct Tag: SwiftyJson, Identifiable {
    var createdAt : String
    var id : Int
    var name : String
    var nameSlug : String
    var object : String
    var updatedAt : String

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON){
        createdAt = json["created_at"].stringValue
        id = json["id"].intValue
        name = json["name"].stringValue
        nameSlug = json["name_slug"].stringValue
        object = json["object"].stringValue
        updatedAt = json["updated_at"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        dictionary["created_at"] = createdAt
        dictionary["id"] = id
        dictionary["name"] = name
        dictionary["name_slug"] = nameSlug
        dictionary["object"] = object
        dictionary["updated_at"] = updatedAt
        return dictionary
    }
}
