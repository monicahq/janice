//
//  View+Extension.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-30.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
