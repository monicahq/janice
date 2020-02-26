//
//  Contact.swift
//  Monica
//
//  Created by julien hamon on 2019-11-20.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Contact: Identifiable, SwiftyJson {
    let lastActivityTogether: Date?
//    var account : Account
    let addresses : [Address]
    let completeName : String
    let createdAt : String
    let descriptionField : String
    let firstName : String
    let gender : String
    let genderType : String
    let hashId : String
    let id : Int
    let information : Information?
    let isActive : Bool
    let isDead : Bool
    let isMe : Bool
    let isPartial : Bool
    let isStarred : Bool
    let lastCalled : String
    let lastName : String
    let nickname : String
    let object : String
//    let statistics : Statistic!
//    let stayInTouchFrequency : AnyObject!
//    let stayInTouchTriggerDate : AnyObject!
//    let tags : [Tag]!
    let updatedAt : String!
    var contactFields : [ContactField]?
    var notes : [Note]?
    let url : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON){
        if json.isEmpty{
            assertionFailure("No Json")
        }
        let addressesArray = json["addresses"].arrayValue
        var addressesCustArray = [Address]()
        for addressesJson in addressesArray {
            let value = Address(fromJson: addressesJson)
            addressesCustArray.append(value)
        }
        addresses = addressesCustArray

        completeName = json["complete_name"].stringValue
        createdAt = json["created_at"].stringValue
        descriptionField = json["description"].stringValue
        firstName = json["first_name"].stringValue
        gender = json["gender"].stringValue
        genderType = json["gender_type"].stringValue
        hashId = json["hash_id"].stringValue
        id = json["id"].intValue
        let informationJson = json["information"]
        if !informationJson.isEmpty{
            information = Information(fromJson: informationJson)
        }
        else {information = nil}

        var contactFieldsArray = [ContactField]()
        for contactFieldsJson in json["contactFields"].arrayValue {
            let value = ContactField(fromJson: contactFieldsJson)
            contactFieldsArray.append(value)
        }
        contactFields = contactFieldsArray

        isActive = json["is_active"].boolValue
        isDead = json["is_dead"].boolValue
        isMe = json["is_me"].boolValue
        isPartial = json["is_partial"].boolValue
        isStarred = json["is_starred"].boolValue
        lastActivityTogether = json["last_activity_together"].date
        lastCalled = json["last_called"].stringValue
        lastName = json["last_name"].stringValue
        nickname = json["nickname"].stringValue
        var notesArray = [Note]()
        for notesJson in json["notes"].arrayValue {
            let value = Note(fromJson: notesJson)
            notesArray.append(value)
        }
        notes = notesArray

        object = json["object"].stringValue
//        let statisticsJson = json["statistics"]
//        if !statisticsJson.isEmpty{
//            statistics = Statistic(fromJson: statisticsJson)
//        }
//        stayInTouchFrequency = json["stay_in_touch_frequency"]
//        stayInTouchTriggerDate = json["stay_in_touch_trigger_date"]
//        tags = [Tag]()
//        let tagsArray = json["tags"].arrayValue
//        for tagsJson in tagsArray{
//            let value = Tag(fromJson: custArrayJson)
//            custArray.append(value)
//        }
        updatedAt = json["updated_at"].stringValue
        url = json["url"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
            var dictionaryElements = [[String:Any]]()
            for addressesElement in addresses {
                dictionaryElements.append(addressesElement.toDictionary())
            }
            dictionary["addresses"] = dictionaryElements
            dictionary["complete_name"] = completeName
            dictionary["created_at"] = createdAt
            dictionary["description"] = descriptionField
            dictionary["first_name"] = firstName
            dictionary["gender"] = gender
            dictionary["gender_type"] = genderType
            dictionary["hash_id"] = hashId
            dictionary["id"] = id
        if let information = information {
            dictionary["information"] = information.toDictionary()

        }
            dictionary["is_active"] = isActive
            dictionary["is_dead"] = isDead
            dictionary["is_me"] = isMe
            dictionary["is_partial"] = isPartial
            dictionary["is_starred"] = isStarred
            dictionary["last_activity_together"] = lastActivityTogether
            dictionary["last_called"] = lastCalled
            dictionary["last_name"] = lastName
            dictionary["nickname"] = nickname
            dictionary["object"] = object
//        if statistics != nil{
//            dictionary["statistics"] = statistics.toDictionary()
//        }
//        if stayInTouchFrequency != nil{
//            dictionary["stay_in_touch_frequency"] = stayInTouchFrequency
//        }
//        if stayInTouchTriggerDate != nil{
//            dictionary["stay_in_touch_trigger_date"] = stayInTouchTriggerDate
//        }
//        if tags != nil{
//            var dictionaryElements = [[String:Any]]()
//            for tagsElement in tags {
//                dictionaryElements.append(tagsElement.toDictionary())
//            }
//            dictionary["tags"] = dictionaryElements
//        }
        if updatedAt != nil{
            dictionary["updated_at"] = updatedAt
        }
        if url != nil{
            dictionary["url"] = url
        }
        return dictionary
    }
}

#if DEBUG
extension Contact {
    init() {
        self.addresses = [Address]()
        self.completeName = ""
        self.contactFields = nil
        self.createdAt = ""
        self.descriptionField = "description"
        self.firstName = "firstName"
        self.lastName = "lastname"
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
