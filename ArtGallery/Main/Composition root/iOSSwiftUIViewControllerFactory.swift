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
        let loader = RemoteArtworkBriefLoader(client: createAuthenticatedHTTPClient())
        let viewModel = ArtworkBriefSearchViewModel(artworkBriefLoader: loader, briefsLoadedAction: briefsLoadedAction)
        let view = ArtworkBriefSearchView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
    
    func briefListViewController(searchQuery: String, briefs: [ArtworkBrief], briefTapAction: @escaping (Artwork) -> Void) -> UIViewController {
        let loader = RemoteArtworkLoader(client: createAuthenticatedHTTPClient())
        let viewModel = ArtworkBriefListViewModel(artworkLoader: loader, searchQuery: searchQuery, briefs: briefs, briefTapAction: briefTapAction)
        let view = ArtworkBriefListView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
    
    func detailViewController(artwork: Artwork) -> UIViewController {
        let viewModel = ArtworkViewModel(artwork: artwork)
        let view = ArtworkView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
    
    private func createAuthenticatedHTTPClient() -> HTTPClient {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "RIJKSMUSEUM_API_KEY") as! String
        return AuthenticatedHTTPClientDecorator(httpClient: URLSession.shared, apiKey: apiKey)
    }
}
