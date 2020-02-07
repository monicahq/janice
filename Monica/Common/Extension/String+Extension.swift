//
//  String+Extension.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-30.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Foundation
import SwiftUI

extension String {
    static let empty = ""
    static let space = " "
}

extension String {
    enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
    }

    func isValid(regex: RegularExpressions) -> Bool {
        isValid(regex: regex.rawValue)
    }
    
    func isValid(regex: String) -> Bool {
        range(of: regex, options: .regularExpression) != nil
    }

    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) }
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }

    func makeACall() {
        guard   isValid(regex: .phone),
                let url = URL(string: "tel://\(self.onlyDigits())"),
                UIApplication.shared.canOpenURL(url) else { return }
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
