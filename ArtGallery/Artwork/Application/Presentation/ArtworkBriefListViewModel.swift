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
    
    private let artworkBriefLoader: ArtworkBriefLoader
    private var bag = Set<AnyCancellable>()

    let searchQuery: String
    let briefTapAction: (ArtworkBrief) -> Void
    
    init(artworkBriefLoader: ArtworkBriefLoader, searchQuery: String, briefTapAction: @escaping (ArtworkBrief) -> Void) {
        self.artworkBriefLoader = artworkBriefLoader
        self.searchQuery = searchQuery
        self.briefTapAction = briefTapAction
        self.briefs = []
        
        self.performSearch()
    }
    
    func performSearch() {
        self.artworkBriefLoader.loadBriefs(for: searchQuery)
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
                DispatchQueue.main.async {
                    self.briefs = briefs
                }
            })
            .store(in: &bag)
    }
    
    func showArtworkDetails(for artworkBrief: ArtworkBrief) {
        self.briefTapAction(artworkBrief)
    }
}
