//
//  DataModel.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-17.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Foundation
import SwiftyJSON

struct DataModel<T> where T : SwiftyJson {
    let data: T

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON){
        if json.isEmpty{
            assertionFailure("No JSON.")
        }

        let dataJson = json["data"]
        data = T.init(fromJson: dataJson)
    }
}

extension DataModel: Decodable {

}
