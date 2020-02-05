//
//  ActivitiesView.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-21.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Foundation
import Combine

class ActivitiesViewModel: ObservableObject, UnidirectionalDataFlow {

    // MARK: Public Properties

    enum Input {
        case onAppear
    }

    @Published var activities:[Activity] = []

    // MARK: Private Properties

    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private var disposables = Set<AnyCancellable>()
    private let activityService = MonicaAssembler.sharedInstance.assembler.resolver.resolve(ActivityService.self)!

    // MARK: Init


    /// Default initializer.
    /// - Parameter idContact: Contact id of activities.
    init(idContact: Int){
        onAppearSubject
            .flatMap{ self.activityService.getActivitiesForContact(contactId: String(idContact)) }
            .sink { activities in
                self.activities = activities
        }.store(in: &disposables)
    }

    // MARK: Public Functions
    
    func apply(_ input: Input) {
        switch input {
        case .onAppear: onAppearSubject.send(())
        }
    }
}
