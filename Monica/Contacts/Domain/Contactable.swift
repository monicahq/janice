//
//  Contactable.swift
//  Monica
//
//  Created by Julien Hamon on 2020-02-21.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Foundation
import Combine

protocol Contactable {
    func getContacts(params:Any?) -> AnyPublisher<[Contact], Error>
}
