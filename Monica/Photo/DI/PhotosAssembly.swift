//
//  PhotosAssembly.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-13.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Foundation
import Swinject
import Moya

class PhotosAssembly: Assembly {
    func assemble(container: Container) {

        container.register(PhotoAPI.self) { resolver in
            return PhotoAPI(provider: resolver.resolve(MoyaProvider<MultiTarget>.self)!)
        }
        container.register(PhotoService.self) { _ in
            return PhotoService()
        }
    }

}
