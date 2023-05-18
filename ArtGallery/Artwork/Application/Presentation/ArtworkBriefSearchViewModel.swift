//
//  ArtworkBriefSearchViewModel.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/11/23.
//

import Foundation
import Combine

@MainActor final class ArtworkBriefSearchViewModel: ObservableObject {
    private let artworkBriefLoader: ArtworkBriefLoader
    private var bag = Set<AnyCancellable>()
    
    @Published var queryText: String = ""
    let briefsLoadedAction: (String, [ArtworkBrief]) -> Void
    
    var isPerformSearchDisabled: Bool {
        return queryText.isEmpty
    }
    
    init(artworkBriefLoader: ArtworkBriefLoader, briefsLoadedAction: @escaping (String, [ArtworkBrief]) -> Void) {
        self.artworkBriefLoader = artworkBriefLoader
        self.briefsLoadedAction = briefsLoadedAction
    }
    
    func performSearch() {
        self.artworkBriefLoader.loadBriefs(for: queryText)
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
                self.briefsLoadedAction(self.queryText, briefs)
            })
            .store(in: &bag)
    }
}
