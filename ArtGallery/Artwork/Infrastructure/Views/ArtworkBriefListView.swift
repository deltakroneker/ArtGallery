//
//  ArtworkBriefListView.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/16/23.
//

import SwiftUI
import Combine

struct ArtworkBriefListView: View {
    @ObservedObject var viewModel: ArtworkBriefListViewModel
    
    var body: some View {
        Group {
            List {
                ForEach(viewModel.briefs) { brief in
                    ArtworkBriefItemView(viewModel: ArtworkBriefItemViewModel(artworkBrief: brief))
                        .onTapGesture {
                            viewModel.performSearch(id: brief.objectNumber)
                        }
                }
            }
            .navigationTitle("\"\(viewModel.searchQuery)\"")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ArtworkBriefListView_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkBriefListView(viewModel: ArtworkBriefListViewModel(artworkLoader: RemoteArtworkLoaderMock(), searchQuery: "van gogh", briefs: ArtworkBrief.dummyData, briefTapAction: { _ in }))
    }
}

struct RemoteArtworkLoaderMock: ArtworkLoader {
    func loadArtwork(for id: String) -> AnyPublisher<Artwork, Error> {
        Just(Artwork.dummyData.first!)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
