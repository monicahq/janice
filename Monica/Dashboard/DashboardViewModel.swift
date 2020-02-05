//
//  LoginViewModel.swift
//  Monica
//
//  Created by julien hamon on 2019-11-20.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import Foundation
import Combine

class DashboardViewModel: ObservableObject, UnidirectionalDataFlow {
    
    //    private let oauthswift = OAuth1Swift(
    //        consumerKey:    "35",
    //        consumerSecret: "6iGJzDnp7P79YcRUZKOSCvAgeDTGWLfaBkXQR8Ya"
    //    )

    enum Input {
        case onAppear
    }

    func apply(_ input: Input) {
        switch input {
        case .onAppear: onAppearSubject.send(())
        }
    }

    @Published var contacts:[Contact] = []
    @Published var reminders:[Reminder] = []
    @Published var activities:[Activity] = []
    
    private let contactAPI = MonicaAssembler.sharedInstance.assembler.resolver.resolve(ContactAPI.self)!
    private let activityAPI = MonicaAssembler.sharedInstance.assembler.resolver.resolve(ActivityAPI.self)!
    private var disposables = Set<AnyCancellable>()
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    init (){
        onAppearSubject
            .setFailureType(to: Error.self)
            .flatMap { self.contactAPI.getContacts()}
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.contacts = []
                case .finished:
                    break
                }
            }) {self.contacts = $0}
            .store(in: &disposables)

        onAppearSubject
            .setFailureType(to: Error.self)
            .flatMap { self.activityAPI.getReminders()}
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.reminders = []
                case .finished:
                    break
                }
            }) {self.reminders = $0}
        .store(in: &disposables)

        onAppearSubject
            .setFailureType(to: Error.self)
            .flatMap { self.activityAPI.getActivities()}
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.activities = []
                case .finished:
                    break
                }
            }) {self.activities = $0}
        .store(in: &disposables)
    }

    func login(){

        // do your HTTP request without authorize
        //        oauthswift.client.get("https://app.monicahq.com/api") { result in
        //            switch result {
        //            case .success(let response):
        //                debugPrint(response)
        //            case .failure(let error):
        //                debugPrint(error)
        //            }
        //        }
    }
}
