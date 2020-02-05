//
//  PhotoCarrouselViewModel.swift
//  Monica
//
//  Created by Julien Hamon on 2020-01-13.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import Foundation
import Combine

class PhotoCarrouselViewModel: ObservableObject, UnidirectionalDataFlow{

    enum Input {
        case onAppear
    }

    func apply(_ input: Input) {
        switch input {
        case .onAppear : onAppearSubject.send()
        }
    }

    @Published var photos:[Photo] = []

    // MARK: Private Properties

    private let photoService = MonicaAssembler.sharedInstance.assembler.resolver.resolve(PhotoService.self)!
    private var disposables = Set<AnyCancellable>()
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private let id:Int

    init(id:Int) {
        self.id = id
        onAppearSubject
                   .flatMap{self.photoService.getPhotosForContact(contactId: self.id.description)}
                   .sink(receiveCompletion: {[weak self] value in
                       guard let self = self else { return }
                       switch value {
                       case .failure:
                           self.photos = []
                       case .finished:
                           break
                       }
                       },receiveValue: { photos in
                           self.photos = photos
                   }).store(in: &disposables)
    }
}
