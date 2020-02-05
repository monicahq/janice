//
//  Photo.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-13.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import UIKit
import SwiftyJSON


struct Photo : SwiftyJson, Identifiable {

    let contact : Contact
    let createdAt : String
    let filesize : Int
    let id : Int
    let link : String
    let mimeType : String
    let newFilename : String
    let object : String
    let originalFilename : String
    let updatedAt : String

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON){
        if json.isEmpty{
            assertionFailure("No JSON.")
        }
        contact = Contact(fromJson: json["contact"])
        createdAt = json["created_at"].stringValue
        filesize = json["filesize"].intValue
        id = json["id"].intValue
        link = json["link"].stringValue
        mimeType = json["mime_type"].stringValue
        newFilename = json["new_filename"].stringValue
        object = json["object"].stringValue
        originalFilename = json["original_filename"].stringValue
        updatedAt = json["updated_at"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        dictionary["contact"] = contact.toDictionary()
        dictionary["created_at"] = createdAt
        dictionary["filesize"] = filesize
        dictionary["id"] = id
        dictionary["link"] = link
        dictionary["mime_type"] = mimeType
        dictionary["new_filename"] = newFilename
        dictionary["object"] = object
        dictionary["original_filename"] = originalFilename
        dictionary["updated_at"] = updatedAt
        return dictionary
    }
}
