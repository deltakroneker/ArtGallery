//
//  ArtworkBriefListViewModel.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/11/23.
//

import Foundation
import Combine

@MainActor final class ArtworkBriefListViewModel: ObservableObject {
    private let artworkLoader: ArtworkLoader
    private var bag = Set<AnyCancellable>()
    
    @Published var briefs = [ArtworkBrief]()
    
    init(artworkLoader: ArtworkLoader) {
        self.artworkLoader = artworkLoader
    }
    
    func findArtwork(for query: String) {
        self.artworkLoader.loadBriefs(for: query)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Load briefs << finished event >> ")
                    break
                case .failure(let err):
                    print("Load briefs << error event >> ")
                    print(err.localizedDescription)
                }
            }, receiveValue: { [weak self] briefs in
                print("Load briefs << value event >> ")
                guard let self = self else { return }
                self.briefs = briefs
            })
            .store(in: &bag)
    }
}
