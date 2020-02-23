//
//  ContactAssembly.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-12.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Swinject
import Moya

class ContactAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ContactAPI.self) { r in
            return ContactAPI(provider: container.resolve(MoyaProvider<MultiTarget>.self)!)
        }

        container.register(ContactService.self) { r in
            return ContactService()
        }

        container.register(ActivityAPI.self) { r in
            return ActivityAPI(provider: r.resolve(MoyaProvider<MultiTarget>.self)!)
        }
        container.register(ActivityService.self) { r in
            return ActivityService()
        }
        container.register(TagService.self) { r in
            return TagService()
        }
        container.register(TagAPI.self) { r in
            return TagAPI(provider: r.resolve(MoyaProvider<MultiTarget>.self)!)
        }
        container.register(MoyaProvider<MultiTarget>.self) { r in
            return MoyaProvider<MultiTarget>(
                plugins: [
                    AuthPlugin(authentiationService: container.resolve(AuthenticationService.self)!)
            ])
        }.inObjectScope(.container)
    }
}
