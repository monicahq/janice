//
//  Activity.swift
//  Monica
//
//  Created by Julien Hamon on 2019-11-24.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Activity: SwiftyJson, Identifiable {
    let summary: String
    let description: String
    //    var account : Account!
    //    var activityType : ActivityType!
    //    var attendees : Attendee!
    let createdAt : Date
    let happenedAt : Date
    let id : Int
    let object : String
    let updatedAt : Date

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON){
        if json.isEmpty{
            assertionFailure("No JSON.")
        }

        createdAt = json["created_at"].dateValue
        description = json["description"].stringValue
        happenedAt = json["happened_at"].dateValue
        id = json["id"].intValue
        object = json["object"].stringValue
        summary = json["summary"].stringValue
        updatedAt = json["updated_at"].dateValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        dictionary["created_at"] = createdAt
        dictionary["description"] = description
        dictionary["happened_at"] = happenedAt
        dictionary["id"] = id
        dictionary["object"] = object
        dictionary["summary"] = summary
        dictionary["updated_at"] = updatedAt
        return dictionary
    }
}
