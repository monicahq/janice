//
//  UnidirectionalDataFlow.swift
//  Monica
//
//  Created by Julien Hamon on 2019-11-23.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Foundation

protocol UnidirectionalDataFlow {
    associatedtype InputType

    func apply(_ input: InputType)
}
