//
//  Reminder.swift
//  Monica
//
//  Created by Julien Hamon on 2019-11-24.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Reminder: SwiftyJson, Identifiable {
    let id: Int
    let title: String
    let description: String
    let frequencyType: String
    let frequencyNumber: Int
    let contact:Contact?
    let delible:Bool
    let createdAt:Date

    init(fromJson json: JSON){
        if json.isEmpty{
            assertionFailure("No JSON Reminder.")
        }

        let contactJson = json["contact"]
        if !contactJson.isEmpty{
            contact = Contact(fromJson: contactJson)
        }
        else { contact = nil }
        createdAt = json["created_at"].dateValue
        delible = json["delible"].boolValue
        description = json["description"].stringValue
        frequencyNumber = json["frequency_number"].intValue
        frequencyType = json["frequency_type"].stringValue
        id = json["id"].intValue
        title = json["title"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if let contact = contact{
            dictionary["contact"] = contact.toDictionary()
        }
        dictionary["created_at"] = createdAt
        dictionary["delible"] = delible
        dictionary["description"] = description
        dictionary["frequency_number"] = frequencyNumber
        dictionary["frequency_type"] = frequencyType
        dictionary["id"] = id
        dictionary["title"] = title
        return dictionary
    }
}

