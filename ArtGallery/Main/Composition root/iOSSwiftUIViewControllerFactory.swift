//
//  iOSSwiftUIViewControllerFactory.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/9/23.
//

import UIKit
import SwiftUI

class iOSSwiftUIViewControllerFactory: ViewControllerFactory {
    @MainActor func searchViewController(briefsLoadedAction: @escaping (String, [ArtworkBrief]) -> Void) -> UIViewController {
        let loader = RemoteArtworkBriefLoaderMock()
        let viewModel = ArtworkBriefSearchViewModel(artworkBriefLoader: loader, briefsLoadedAction: briefsLoadedAction)
        let view = ArtworkBriefSearchView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
    
    @MainActor func briefListViewController(searchQuery: String, briefs: [ArtworkBrief], briefTapAction: @escaping (ArtworkBrief) -> Void) -> UIViewController {
        let viewModel = ArtworkBriefListViewModel(searchQuery: searchQuery, briefs: briefs, briefTapAction: briefTapAction)
        let view = ArtworkBriefListView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
}
