//
//  Adresse.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-18.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Address: Decodable, Identifiable {
     var city : String!
     var contact : Contact!
//     var country : Country!
     var createdAt : String!
     var id : Int
     var latitude : Float!
     var longitude : Float!
     var name : String!
     var object : String!
     var postalCode : String!
     var province : String!
     var street : String!
     var updatedAt : String!
     var url : String!

     /**
      * Instantiate the instance using the passed json values to set the properties values
      */
     init(fromJson json: JSON!){
         if json.isEmpty{
             assertionFailure("No json")
         }
         city = json["city"].stringValue
         let contactJson = json["contact"]
         if !contactJson.isEmpty{
             contact = Contact(fromJson: contactJson)
         }
//         let countryJson = json["country"]
//         if !countryJson.isEmpty{
//             country = Country(fromJson: countryJson)
//         }
         createdAt = json["created_at"].stringValue
         id = json["id"].intValue
         latitude = json["latitude"].floatValue
         longitude = json["longitude"].floatValue
         name = json["name"].stringValue
         object = json["object"].stringValue
         postalCode = json["postal_code"].stringValue
        province = json["province"].stringValue
         street = json["street"].stringValue
         updatedAt = json["updated_at"].stringValue
         url = json["url"].stringValue
     }

     /**
      * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
      */
     func toDictionary() -> [String:Any]
     {
         var dictionary = [String:Any]()
         if city != nil{
             dictionary["city"] = city
         }
         if contact != nil{
             dictionary["contact"] = contact.toDictionary()
         }
//         if country != nil{
//             dictionary["country"] = country.toDictionary()
//         }
         if createdAt != nil{
             dictionary["created_at"] = createdAt
         }
        dictionary["id"] = id
         if latitude != nil{
             dictionary["latitude"] = latitude
         }
         if longitude != nil{
             dictionary["longitude"] = longitude
         }
         if name != nil{
             dictionary["name"] = name
         }
         if object != nil{
             dictionary["object"] = object
         }
         if postalCode != nil{
             dictionary["postal_code"] = postalCode
         }
         if province != nil{
             dictionary["province"] = province
         }
         if street != nil{
             dictionary["street"] = street
         }
         if updatedAt != nil{
             dictionary["updated_at"] = updatedAt
         }
         if url != nil{
             dictionary["url"] = url
         }
         return dictionary
     }

    func getCompleteAdress() -> String {
        var adress = ""
        if !street.isEmpty {
            adress += street + " "
        }

        if !postalCode.isEmpty {
            adress += postalCode + " "
        }

        if !city.isEmpty {
            adress += city
        }
        return adress
    }
}
