//
//  iOSSwiftUIViewControllerFactory.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/9/23.
//

import UIKit
import SwiftUI

class iOSSwiftUIViewControllerFactory: ViewControllerFactory {
    func searchViewController(searchButtonAction: @escaping (String) -> Void) -> UIViewController {
        let viewModel = ArtworkBriefSearchViewModel(searchButtonAction: searchButtonAction)
        let view = ArtworkBriefSearchView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
    
    func briefListViewController(searchQuery: String, briefTapAction: @escaping (ArtworkBrief) -> Void) -> UIViewController {
        let loader = RemoteArtworkBriefLoader(client: createAuthenticatedHTTPClient())
        let viewModel = ArtworkBriefListViewModel(artworkBriefLoader: loader, searchQuery: searchQuery, briefTapAction: briefTapAction)
        let view = ArtworkBriefListView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
    
    func detailViewController(artworkBrief: ArtworkBrief) -> UIViewController {
        let loader = RemoteArtworkLoader(client: createAuthenticatedHTTPClient())
        let viewModel = ArtworkViewModel(artworkLoader: loader, artworkBrief: artworkBrief)
        let view = ArtworkView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
    
    private func createAuthenticatedHTTPClient() -> HTTPClient {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "RIJKSMUSEUM_API_KEY") as! String
        return AuthenticatedHTTPClientDecorator(httpClient: URLSession.shared, apiKey: apiKey)
    }
}
