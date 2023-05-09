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
    
    func start() {}
}
