//
//  ArtworkViewModel.swift
//  ArtGallery
//
//  Created by nikolamilic on 6/7/23.
//

import Foundation
import Combine

class ArtworkViewModel: ObservableObject {
    private var artwork: Artwork? {
        didSet {
            self.title = self.artwork?.title ?? "No title"
            self.subtitle = self.artwork?.principalMaker ?? "Unknown maker"
            self.description = self.artwork?.description ?? "No description"
            self.imageURLString = self.artwork?.webImageURLString
        }
    }
    
    @Published var title: String = "Loading..."
    @Published var subtitle: String = ""
    @Published var description: String = ""
    @Published var imageURLString: String?

    private let artworkLoader: ArtworkLoader
    private let artworkBrief: ArtworkBrief
    private var bag = Set<AnyCancellable>()
    
    var imageURL: URL? { (imageURLString != nil) ? URL(string: imageURLString!) : nil }
    
    init(artworkLoader: ArtworkLoader, artworkBrief: ArtworkBrief) {
        self.artworkLoader = artworkLoader
        self.artworkBrief = artworkBrief
        
        self.performSearch()
    }
    
    func performSearch() {
        self.artworkLoader.loadArtwork(for: artworkBrief.objectNumber)
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
                self.artwork = artwork
            })
            .store(in: &bag)
    }
}
