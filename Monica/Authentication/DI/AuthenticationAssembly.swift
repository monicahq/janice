//
//  AuthenticationAssembly.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-11.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Swinject

class AuthenticationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AuthenticationService.self) { r in
           return AuthenticationService()
        }.inObjectScope(.container)

        container.register(AuthenticationApi.self) { r in
           return AuthenticationApi()
        }.inObjectScope(.container)
    }
}

