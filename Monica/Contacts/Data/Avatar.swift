//
//  Avatar.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-11.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftyJSON


struct Avatar: Decodable {

    var defaultAvatarColor : String
    var source : String
    var url : String

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON){
        if json.isEmpty{
            assertionFailure("No JSON.")
        }
        defaultAvatarColor = json["default_avatar_color"].stringValue
        source = json["source"].stringValue
        url = json["url"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        dictionary["default_avatar_color"] = defaultAvatarColor
        dictionary["source"] = source
        dictionary["url"] = url

        return dictionary
    }
}
