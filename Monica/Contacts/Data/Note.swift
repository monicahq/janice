//
//  Note.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-22.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Note: SwiftyJson, Identifiable {

    var body : String
    var contact : Contact
    var createdAt : Date
    var favoritedAt : Date
    var id : Int
    var isFavorited : Bool
    var object : String
    var updatedAt : Date

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON){
        if json.isEmpty{
            assertionFailure("No JSON.")
        }

        body = json["body"].stringValue
        contact = Contact(fromJson: json["contact"])
        createdAt = json["created_at"].dateValue
        favoritedAt = json["favorited_at"].dateValue
        id = json["id"].intValue
        isFavorited = json["is_favorited"].boolValue
        object = json["object"].stringValue
        updatedAt = json["updated_at"].dateValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        dictionary["body"] = body
        dictionary["contact"] = contact.toDictionary()
        dictionary["created_at"] = createdAt
        dictionary["favorited_at"] = favoritedAt
        dictionary["id"] = id
        dictionary["is_favorited"] = isFavorited
        dictionary["object"] = object
        dictionary["updated_at"] = updatedAt
        return dictionary
    }
}
