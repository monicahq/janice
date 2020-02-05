//
//  DateFormatter+Extension.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-18.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Foundation

extension DateFormatter {

    /// Formats the date with yyyy-MM-dd'T'HH:mm:ss.SSSSSZ .
    static let standardTMilliseconds: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSZ"
        return dateFormatter
    }()

    /// Formats the date with yyyy-MM-dd'T'HH:mm:ss.SSSSSZ .
    static let standardT: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()

    /// Formats the date with MMM dd,yyyy .
     static let standardMonth: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter
    }()
}
