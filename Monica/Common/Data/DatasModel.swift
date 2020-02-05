//
//  DataModel.swift
//  Monica
//
//  Created by Julien Hamon on 2019-11-24.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Foundation
import SwiftyJSON

struct DatasModel<T> where T : SwiftyJson {
    let data: [T]


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON){
        if json.isEmpty{
            assertionFailure("No JSON.")
        }

        var custArray = [T]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = T.init(fromJson: dataJson)
            custArray.append(value)
        }
        data = custArray

    }
}

extension DatasModel: Decodable {

}

