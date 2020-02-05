//
//  RootViewModel.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-09.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Foundation
import Combine

class AppRootViewModel: ObservableObject, UnidirectionalDataFlow {

    // MARK: Public Properties
    @Published var isConnected:Bool = false

    // MARK: UnidirectionalDataFlow

    enum Input {
    }

    // MARK: Private Properties
    private var disposables = Set<AnyCancellable>()
    private let authenticationService = MonicaAssembler.sharedInstance.assembler.resolver.resolve(AuthenticationService.self)!

    // MARK: Default Initializer

    init() {
        authenticationService.isConnected()
            .assign(to: \.isConnected, on: self)
            .store(in: &disposables)
    }

    func apply(_ input: Input) {
    }

}
