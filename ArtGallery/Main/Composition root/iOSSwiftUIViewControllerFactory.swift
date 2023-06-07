//
//  iOSSwiftUIViewControllerFactory.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/9/23.
//

import UIKit
import SwiftUI

class iOSSwiftUIViewControllerFactory: ViewControllerFactory {
    func searchViewController(briefsLoadedAction: @escaping (String, [ArtworkBrief]) -> Void) -> UIViewController {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "RIJKSMUSEUM_API_KEY") as! String
        let httpClient = AuthenticatedHTTPClientDecorator(httpClient: URLSession.shared, apiKey: apiKey)
        let loader = RemoteArtworkBriefLoader(client: httpClient)
        let viewModel = ArtworkBriefSearchViewModel(artworkBriefLoader: loader, briefsLoadedAction: briefsLoadedAction)
        let view = ArtworkBriefSearchView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
    
    func briefListViewController(searchQuery: String, briefs: [ArtworkBrief], briefTapAction: @escaping (ArtworkBrief) -> Void) -> UIViewController {
        let viewModel = ArtworkBriefListViewModel(searchQuery: searchQuery, briefs: briefs, briefTapAction: briefTapAction)
        let view = ArtworkBriefListView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
}
