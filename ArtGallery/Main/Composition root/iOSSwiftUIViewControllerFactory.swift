//
//  iOSSwiftUIViewControllerFactory.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/9/23.
//

import UIKit
import SwiftUI
import Combine

class iOSSwiftUIViewControllerFactory: ViewControllerFactory {
    func homeScreen(searchButtonAction: @escaping (String) -> Void) -> UIViewController {
        let viewModel = HomeScreenViewModel(searchButtonAction: searchButtonAction)
        let view = HomeScreen(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
    
    func briefListViewController(searchQuery: String, briefTapAction: @escaping (ArtworkBrief) -> Void) -> UIViewController {
        let loader: ArtworkBriefLoader = MainQueueDispatchDecorator(
            RemoteArtworkBriefLoader(client: createAuthenticatedHTTPClient())
        )
        let viewModel = ArtworkBriefListViewModel(artworkBriefLoader: loader, searchQuery: searchQuery, briefTapAction: briefTapAction)
        let view = ArtworkBriefListView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
    
    func detailViewController(artworkBrief: ArtworkBrief) -> UIViewController {
        let loader: ArtworkLoader = MainQueueDispatchDecorator(
            RemoteArtworkLoader(client: createAuthenticatedHTTPClient())
        )
        let viewModel = ArtworkViewModel(artworkLoader: loader, artworkBrief: artworkBrief)
        let view = ArtworkView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
    
    private func createAuthenticatedHTTPClient() -> HTTPClient {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "RIJKSMUSEUM_API_KEY") as! String
        return AuthenticatedHTTPClientDecorator(httpClient: URLSession.shared, apiKey: apiKey)
    }
}

extension MainQueueDispatchDecorator: ArtworkBriefLoader where T == ArtworkBriefLoader {
    func loadBriefs(for query: String) -> AnyPublisher<[ArtworkBrief], Error> {
        return decoratee.loadBriefs(for: query)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension MainQueueDispatchDecorator: ArtworkLoader where T == ArtworkLoader {
    func loadArtwork(for objectNumber: String) -> AnyPublisher<Artwork, Error> {
        return decoratee.loadArtwork(for: objectNumber)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
