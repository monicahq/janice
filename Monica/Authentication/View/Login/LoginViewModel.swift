//
//  LoginViewModel.swift
//  Monica
//
//  Created by Julien Hamon on 2019-12-09.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject, UnidirectionalDataFlow {

    
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
            .flatMap { self.authenticationAPI.login(username: $0[0], password: $0[1]) }
            .sink(receiveCompletion: { value in
                switch value {
                case .failure:
                    break
                case .finished:
                    break
                }
            }) { response in
                print(response)
        }.store(in: &disposables)
    }

}
