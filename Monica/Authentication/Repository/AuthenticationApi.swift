//
//  AuthenticationApi.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-08.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Foundation
import Alamofire
import Combine

class AuthenticationApi: NSObject {

    func login(email:String, password:String) -> Future<String, Error> {
        let parameters = ["email":email,"password": password]

        return Future { promise in
            AF.request("https://app.monicahq.com/oauth/login",
                       method: .post,
                       parameters: parameters)
                .validate()
                .responseJSON(completionHandler:{ response in
                    switch response.result {
                    case .success (let data):
                        guard let json = data  as? [String:Any],
                            let token = json["access_token"] as? String else {
                                return
                        }
                        promise(.success(token))
                    case let .failure(error):
                        promise(.failure(error))
                    }
            })
        }
    }

}
