//
//  Date+Extension.swift
//  Monica
//
//  Created by Julien Hamon on 2020-02-04.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import UIKit

extension Date {

    /// Gets age with a birthday date.
    func getAge() -> Int {
        let now = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: self, to: now)
        return ageComponents.year!
    }
}
