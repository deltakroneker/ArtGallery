//
//  ArtworkBriefListViewModel.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/16/23.
//

import Foundation
import Combine

final class ArtworkBriefListViewModel: ObservableObject {
    @Published var briefs: [ArtworkBrief]
    
    private let artworkLoader: ArtworkLoader
    private var bag = Set<AnyCancellable>()

    let searchQuery: String
    let briefTapAction: (Artwork) -> Void
    
    init(artworkLoader: ArtworkLoader, searchQuery: String, briefs: [ArtworkBrief], briefTapAction: @escaping (Artwork) -> Void) {
        self.artworkLoader = artworkLoader
        self.searchQuery = searchQuery
        self.briefs = briefs
        self.briefTapAction = briefTapAction
    }
    
    func performSearch(id: String) {
        self.artworkLoader.loadArtwork(for: id)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Load artwork << finished event >> ")
                    break
                case .failure(let err):
                    print("Load artwork << error event >> ")
                    print(err.localizedDescription)
                }
            }, receiveValue: { [weak self] artwork in
                print("Load artwork << value event >> ")
                guard let self = self else { return }
                self.briefTapAction(artwork)
            })
            .store(in: &bag)
    }
}
