//
//  NavigationControllerRouter.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/9/23.
//

import UIKit

final class NavigationControllerRouter {
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    private let dispatchQueue: Dispatching
    
    init(_ navigationController: UINavigationController, factory: ViewControllerFactory, dispatchQueue: Dispatching = DispatchQueue.main) {
        self.navigationController = navigationController
        self.factory = factory
        self.dispatchQueue = dispatchQueue
    }
    
    func start() {
        let searchVC = factory.homeScreen(searchButtonAction: searchScreenButtonAction)
        self.navigationController.pushViewController(searchVC, animated: true)
    }
    
    private func searchScreenButtonAction(_ searchQuery: String) {
        dispatchQueue.async(execute: DispatchWorkItem(block: {
            let listVC = self.factory.briefListViewController(searchQuery: searchQuery, briefTapAction: self.listScreenBriefTapAction)
            self.navigationController.pushViewController(listVC, animated: true)
        }))
    }
    
    private func listScreenBriefTapAction(_ brief: ArtworkBrief) {
        dispatchQueue.async(execute: DispatchWorkItem(block: {
            let detailsVC = self.factory.detailViewController(artworkBrief: brief)
            self.navigationController.pushViewController(detailsVC, animated: true)
        }))
    }
}
