//
//  ArtworkBriefSearchView.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/16/23.
//

import SwiftUI
import Combine

struct ArtworkBriefSearchView: View {
    @ObservedObject var viewModel: ArtworkBriefSearchViewModel
    
    var body: some View {
        VStack {
            Form {
                TextField("Enter artists name...", text: $viewModel.queryText)
                Button("Search") {
                    viewModel.performSearch()
                }
            }
        }
    }
}

struct ArtworkBriefSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkBriefSearchView(viewModel: ArtworkBriefSearchViewModel(artworkBriefLoader: RemoteArtworkBriefLoaderMock(), briefsLoadedAction: { _ in }))
    }
}

fileprivate struct RemoteArtworkBriefLoaderMock: ArtworkBriefLoader {
    func loadBriefs(for query: String) -> AnyPublisher<[ArtworkBrief], Error> {
        Just([ArtworkBrief.dummyData.first!])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
