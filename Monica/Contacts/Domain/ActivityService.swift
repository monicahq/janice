//
//  ActivityService.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-21.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Foundation
import Combine

class ActivityService {

    private let activityApi = MonicaAssembler.sharedInstance.assembler.resolver.resolve(ActivityAPI.self)!

    func getActivitiesForContact(contactId:String) -> AnyPublisher<[Activity], Never> {
        return activityApi
            .getContactActivities(id: contactId)
            .catch { error in
                Just<[Activity]>([])
            }
            .eraseToAnyPublisher()
    }

}
