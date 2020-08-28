//
//  NavigationConfigurator.swift
//  Monica
//
//  Created by Julien Hamon on 2020-04-22.
//  Copyright © 2020 julien hamon. All rights reserved.
//

import UIKit
import SwiftUI

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}


protocol TransitionLinkType {
    var transition: AnyTransition { get }
}

struct TransitionLink<Content, Destination>: View where Content: View, Destination: View {

    @Binding var isPresented: Bool
    var content: () -> Content
    var destination: () -> Destination

    init(isPresented: Binding<Bool>, @ViewBuilder destination: @escaping () -> Destination, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.destination = destination
        self._isPresented = isPresented
    }

    var body: some View {
        ZStack {
            if self.isPresented {
                self.destination()
            } else {
                self.content()
            }
        }
    }
}

struct ModaLinkViewModifier<Destination>: ViewModifier where Destination: View {

    @Binding var isPresented: Bool
    var destination: () -> Destination

    func body(content: Self.Content) -> some View {
        TransitionLink(isPresented: self.$isPresented,
                       destination: {
                        self.destination()
                            .transition(.move(edge: .bottom))

        }, content: {
            content
        })
    }

}

extension View {

    func modalLink<Destination: View>(isPresented: Binding<Bool>,
                                      destination: @escaping () -> Destination) -> some View {
        self.modifier(ModaLinkViewModifier(isPresented: isPresented,
                                           destination: destination))
    }

}
