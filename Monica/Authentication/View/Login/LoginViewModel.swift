//
//  LoginViewModel.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-09.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import SwiftUI
import Combine

struct ErrorAlertType:Identifiable {
    enum LoginErrorType:Error {
        case errorLogin
    }
    var id: LoginErrorType
}

class LoginViewModel: ObservableObject, UnidirectionalDataFlow {

    // MARK: Public Properties
    @Published var haveError: ErrorAlertType?
    
    // MARK: Private Properties
    private let onButtonCickSubject = PassthroughSubject<[String], Never>()
    private let authenticationAPI = MonicaAssembler.sharedInstance.assembler.resolver.resolve(AuthenticationService.self)!
    private var disposables = Set<AnyCancellable>()
    
    // MARK: UnidirectionalDataFlow
    enum Input {
        case onAppear
        case onButtonCick(login:  Binding<String>, Password:Binding<String>)
    }

    func apply(_ input: Input) {
        switch input {
        case .onAppear: break
        case .onButtonCick(let login,let password):
            onButtonCickSubject.send([login.wrappedValue, password.wrappedValue])
        }
    }


    init() {
        onButtonCickSubject
            .filter { values in
                let emptyValues = values.first(where: { $0.isEmpty })
                if emptyValues?.isEmpty ?? false {
                    self.haveError = ErrorAlertType(id: .errorLogin)
                    return false
                }
                return true
        }
            .sink(receiveValue: { self.refresh(username: $0[0], password: $0[1]) })
            .store(in: &disposables)
    }

    func refresh(username:String, password:String) {
        authenticationAPI.login(username: username, password:password)
            .map{Result<UserSession?,ErrorAlertType.LoginErrorType>.success($0)}
            .sink(receiveCompletion: { value in
                switch value {
                case .failure:
                    break
                case .finished:
                    break
                }
            }) { response in
                switch response {
                case .failure(let error):
                    self.haveError = ErrorAlertType(id: error)
                case .success:
                    print(response)
                }
        }.store(in: &disposables)
    }

}
