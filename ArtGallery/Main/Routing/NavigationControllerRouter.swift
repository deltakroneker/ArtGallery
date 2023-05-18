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
    
    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
        let searchVC = factory.searchViewController(briefsLoadedAction: searchScreenBriefsLoadedAction)
        self.navigationController.pushViewController(searchVC, animated: true)
    }
    
    private func searchScreenBriefsLoadedAction(_ searchQuery: String, _ briefs: [ArtworkBrief]) {
        DispatchQueue.main.async {
            let listVC = self.factory.briefListViewController(searchQuery: searchQuery, briefs: briefs, briefTapAction: self.listScreenBriefTapAction)
            self.navigationController.pushViewController(listVC, animated: true)
        }
    }
    
    private func listScreenBriefTapAction(_ brief: ArtworkBrief) {
        print("TODO: Transition to Artwork details screen")
    }
}
