//
//  ViewControllerFactory.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/9/23.
//

import UIKit

protocol ViewControllerFactory {
    func searchViewController(searchButtonAction: @escaping (String) -> Void) -> UIViewController
    func briefListViewController(searchQuery: String, briefTapAction: @escaping (ArtworkBrief) -> Void) -> UIViewController
    func detailViewController(artworkBrief: ArtworkBrief) -> UIViewController
}
