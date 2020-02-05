//
//  Relationship.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-02.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Foundation
import SwiftyJSON

enum RelationName: String, Decodable {
    case spouse
    case child
    case partner
    case lover
    case parent
    case grandparent
    case grandchild
    case none
}

struct Relationships : SwiftyJson {

    let relationship : [Relationship]
    let total : Int

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON){

        var relationShipJson = [Relationship]()
        for (_,subJsonRelation):(String, JSON) in json["contacts"] {
            relationShipJson.append(Relationship(fromJson: subJsonRelation))
        }
        
        relationship = relationShipJson
        total = json["total"].intValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        dictionary["total"] = total

        var dictionaryElements = [[String:Any]]()
        for relationshipElement in relationship {
            dictionaryElements.append(relationshipElement.toDictionary())
        }

        return dictionary
    }
}



struct Relationship :  Decodable {

    var contact : Contact
    let id : Int
    let name : RelationName

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON){
        id = json["relationship"]["id"].intValue
        name = RelationName(rawValue: json["relationship"]["name"].stringValue) ?? .none
        contact = Contact(fromJson:json["contact"])
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        dictionary["contact"] = contact.toDictionary()
        return dictionary
    }
}

#if DEBUG
extension Relationship {
    init(name:RelationName, id:Int) {
        self.contact = Contact()
        self.id = id
        self.name = name
    }
}
#endif

#if DEBUG
extension Contact {
    init() {
        self.addresses = [Address]()
        self.completeName = ""
        self.contactFields = nil
        self.createdAt = ""
        self.descriptionField = ""
        self.firstName = ""
        self.lastName = ""
        self.gender = ""
        self.genderType = ""
        self.lastActivityTogether = nil
        self.hashId = ""
        self.id = 0
        self.information = nil
        self.isActive = true
        self.isDead = false
        self.isMe = false
        self.isPartial = false
        self.lastCalled = ""
        self.nickname = ""
        self.object = ""
        self.updatedAt = ""
        self.url = ""
        self.isStarred = false
        self.notes = nil
    }
}
#endif
