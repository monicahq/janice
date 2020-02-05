//
//  ImageLettersView.swift
//  Monica
//
//  Created by julien hamon on 2019-12-01.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import SwiftUI
import InitialsImageView

struct ImageLettersView: UIViewRepresentable {
    let text: String
    let width: Double
    let height: Double
    
    func makeUIView(context: UIViewRepresentableContext<ImageLettersView>) -> UIImageView {
        let randomImage = UIImageView.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        randomImage.setImageForName(text, circular: true, textAttributes: nil, gradient: true)
        return randomImage
    }

    func updateUIView(_ uiView: UIImageView, context: UIViewRepresentableContext<ImageLettersView>) {
    }

    typealias UIViewType = UIImageView
}
