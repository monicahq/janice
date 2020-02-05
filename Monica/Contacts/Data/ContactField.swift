//
//  ContactField.swift
//  Monica
//
//  Created by Julien Hamon on 2020-02-01.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Foundation
import SwiftyJSON


struct ContactField : Identifiable, Decodable{

    let contact : Contact
    let contactFieldType : ContactFieldType
    let content : String
    let createdAt : Date
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
        contact = Contact(fromJson: json["contact"])
        contactFieldType = ContactFieldType(fromJson: json["contact_field_type"])
        content = json["content"].stringValue
        createdAt = json["created_at"].dateValue
        id = json["id"].intValue
        object = json["object"].stringValue
        updatedAt = json["updated_at"].dateValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        dictionary["contact"] = contact.toDictionary()
        dictionary["contactFieldType"] = contactFieldType.toDictionary()
        dictionary["content"] = content
        dictionary["created_at"] = createdAt
        dictionary["id"] = id
        dictionary["object"] = object
        dictionary["updated_at"] = updatedAt
        return dictionary
    }
}

extension ContactField {
    func toContactFieldDto() -> ContactFieldDTO {
        var type = ContactFieldDTO.ContactFieldType.other
        var imageName = ""
        switch contactFieldType.protocolType {
        case "mailto:":
            type = .mail
        case "tel:":
            type = .tel
            imageName = "mobile"
        default:
            if contactFieldType.name == "Twitter" {
                type = .twitter
                imageName = "twitter"
            }else {
                type = .other
            }
        }

        return ContactFieldDTO(id: id,
                               value: content,
                               imageName: imageName,
                               type: type)
    }
}
