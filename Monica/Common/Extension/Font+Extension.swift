//
//  Font+Extension.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-20.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import SwiftUI

extension Font {

    static func SFUIDisplayFontRegularSeventeen() -> Font
    {
        return .system(size: 17.0, weight: .regular, design: .default)
    }

    static func SFUIDisplayFontSemiBoldSeventeen() -> Font
    {
        return .system(size: 17.0, weight: .semibold, design: .default)
    }

    static func SFUIDisplayFontBoldTitle() -> Font
    {
        return .system(size: 34.0, weight: .bold, design: .default)
    }

    static func SFUIDisplayFontRegularTwelve() -> Font
    {
        return .system(size: 12.0, weight: .regular, design: .default)
    }
}
