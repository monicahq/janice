//
//  MonicaAssembler.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-11.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Swinject

class MonicaAssembler {
    // MARK: - Public Properties

    /// Properties for the singleton instance of MonicaAssembler
    static let sharedInstance = MonicaAssembler()

    /// The Assembler with all assemblies available.
    let assembler: Assembler

    init() {
        assembler = Assembler(
            [
                AuthenticationAssembly(),
                ContactAssembly(),
                PhotosAssembly()
        ])
    }
}
