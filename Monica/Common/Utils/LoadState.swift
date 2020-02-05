//
//  LoadState.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-31.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import UIKit

public enum ListState<T> {
    case error(_ error: Error)
    case items(data: T)
    case loading
}
