//
//  ContactFieldDTO.swift
//  Monica
//
//  Created by Julien Hamon on 2020-02-02.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Foundation

struct ContactFieldDTO: Identifiable {
    enum ContactFieldType {
        case tel
        case mail
        case twitter
        case facebook
        case linkedIn
        case other
    }

    let id:Int
    let value: String
    let imageName: String
    let type: ContactFieldType
}
