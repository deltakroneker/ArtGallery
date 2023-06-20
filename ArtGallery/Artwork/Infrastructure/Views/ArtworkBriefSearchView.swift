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
                TextField("Art title, artist name...", text: $viewModel.queryText)
                Button("Search") {
                    viewModel.performSearch()
                }
                .disabled(viewModel.isPerformSearchDisabled)
            }
        }
    }
}

struct ArtworkBriefSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkBriefSearchView(viewModel: ArtworkBriefSearchViewModel(searchButtonAction: { _ in }))
    }
}

struct RemoteArtworkBriefLoaderMock: ArtworkBriefLoader {
    func loadBriefs(for query: String) -> AnyPublisher<[ArtworkBrief], Error> {
        Just([ArtworkBrief.dummyData.first!])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
