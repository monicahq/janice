//
//  AuthenticationService.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-11.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Foundation
import Combine

class AuthenticationService: ObservableObject {

    // MARK: Private Properties

    private let authenticationApi = AuthenticationApi()
    private var userSession:UserSession?
    private let userSessionSubject: CurrentValueSubject<UserSession?, Never>
    private let userSessionKey = "userSession"

    init() {
        if let userData = KeychainWrapper.shared.getData(forKey: userSessionKey),
            let userSession = try? JSONDecoder().decode(UserSession.self, from: userData) {
            self.userSession = userSession
        }
        self.userSessionSubject = CurrentValueSubject(userSession)
    }

    func login(username:String, password:String)-> AnyPublisher<UserSession?, Error>  {
        return authenticationApi
            .login(email: username, password: password)
            .map {[unowned self] token -> UserSession? in
                if self.saveUserSessionInKeychain(userSession: UserSession(token: token)) {
                    self.userSessionSubject.send(self.userSession!)
                    return self.userSession
                }
                return nil
            }
            .eraseToAnyPublisher()
    }

    func isConnected() -> AnyPublisher<Bool,Never> {
        return userSessionSubject
            .map{ !($0?.token.isEmpty ?? true) }
            .eraseToAnyPublisher()
    }

    func getToken() -> String {
        return userSession?.token ?? ""
    }

    private func saveUserSessionInKeychain(userSession: UserSession) -> Bool {

           if let sessionData = try? JSONEncoder().encode(userSession),
            KeychainWrapper.shared.set(sessionData, forKey: userSessionKey) {
               self.userSession = userSession
               return true
           }
           return false
       }
}
