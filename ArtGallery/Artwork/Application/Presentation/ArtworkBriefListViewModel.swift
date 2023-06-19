//
//  ArtworkBriefListViewModel.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/16/23.
//

import Foundation
import Combine

final class ArtworkBriefListViewModel: ObservableObject {
    @Published var briefs: [ArtworkBrief] {
        didSet {
            isShowingNoResultsAlert = briefs.count == 0
        }
    }
    @Published var isShowingNoResultsAlert = false
    @Published var isShowingErrorAlert: (Bool, String?) = (false, nil)
    
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
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                    self.isShowingErrorAlert = (true, "There was an error. Please try again.")
                }
            }, receiveValue: { [weak self] briefs in
                self?.briefs = briefs
            })
            .store(in: &bag)
    }
    
    func showArtworkDetails(for artworkBrief: ArtworkBrief) {
        self.briefTapAction(artworkBrief)
    }
}
