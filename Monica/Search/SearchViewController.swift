//
//  ResearchContacts.swift
//  Monica
//
//  Created by julien hamon on 2019-11-28.
//  Copyright © 2019 julien hamon. All rights reserved.
//

import SwiftUI
import UIKit
import Combine

struct SearchViewController<Content: View>: UIViewControllerRepresentable {
    typealias UIViewControllerType = UINavigationController
    
    var content: () -> Content
//    let searchResultsView = ContactView()
//    @Binding var text: String
    private let textSubject = PassthroughSubject<String, Never>()
    lazy var publisher = textSubject.eraseToAnyPublisher()
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
//        _text = text
    }
    func makeUIViewController(context: UIViewControllerRepresentableContext<SearchViewController>) -> UINavigationController {
        let rootViewController = UIHostingController(rootView: content())
        let navigationController = UINavigationController(rootViewController: rootViewController)
//        let searchResultsController = UIHostingController(rootView: searchResultsView)

        // Set nav properties
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.definesPresentationContext = true

        // Create search controller
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type something here to search"
        searchController.searchResultsUpdater = context.coordinator

//        searchController.delegate =  context.coordinator
//        searchController.searchBar.delegate = context.coordinator // Monitor when the search button is tapped.

        // Create default view
        rootViewController.navigationItem.searchController = searchController
        rootViewController.title = "Your contacts"

        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: UIViewControllerRepresentableContext<SearchViewController>) {
    }
    
    func makeCoordinator() -> SearchViewController.Coordinator {
        Coordinator(text: textSubject)
    }
    
    class Coordinator: NSObject, UISearchResultsUpdating {
        
        private let text: PassthroughSubject<String, Never>
        init(text:PassthroughSubject<String, Never>) {
            self.text = text
        }
        
        func updateSearchResults(for searchController: UISearchController) {
            guard let text = searchController.searchBar.text else { return }

            self.text.send(text)
        }
    }
    
}
