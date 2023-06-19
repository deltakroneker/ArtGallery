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
                            viewModel.showArtworkDetails(for: brief)
                        }
                }
            }
            .navigationTitle("\"\(viewModel.searchQuery)\"")
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert("No results for \"\(viewModel.searchQuery)\". Try again with a different input.", isPresented: $viewModel.isShowingNoResultsAlert) {
            Button("OK", role: .cancel) {}
        }
        .alert(viewModel.isShowingErrorAlert.1 ?? "", isPresented: $viewModel.isShowingErrorAlert.0) {
            Button("OK", role: .cancel) {}
        }
    }
}

struct ArtworkBriefListView_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkBriefListView(viewModel: ArtworkBriefListViewModel(artworkBriefLoader: RemoteArtworkBriefLoaderMock(), searchQuery: "van gogh", briefTapAction: { _ in }))
    }
}

struct RemoteArtworkLoaderMock: ArtworkLoader {
    func loadArtwork(for id: String) -> AnyPublisher<Artwork, Error> {
        Just(Artwork.dummyData.first!)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
