//
//  ViewControllerFactory.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/9/23.
//

import UIKit

protocol ViewControllerFactory {
    func searchViewController(briefsLoadedAction: @escaping (String, [ArtworkBrief]) -> Void) -> UIViewController
    func briefListViewController(searchQuery: String, briefs: [ArtworkBrief], briefTapAction: @escaping (ArtworkBrief) -> Void) -> UIViewController
}
