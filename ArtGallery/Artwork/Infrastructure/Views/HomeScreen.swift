//
//  HomeScreen.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/16/23.
//

import SwiftUI
import Combine

struct HomeScreen: View {
    @ObservedObject var viewModel: HomeScreenViewModel
    
    var body: some View {
        VStack {
            Form {
                TextField("Art title, artist name...", text: $viewModel.queryText)
                Button("Search Rijksmuseum") {
                    viewModel.performSearch()
                }
                .disabled(viewModel.isPerformSearchDisabled)
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(viewModel: HomeScreenViewModel(searchButtonAction: { _ in }))
    }
}

struct RemoteArtworkBriefLoaderMock: ArtworkBriefLoader {
    func loadBriefs(for query: String) -> AnyPublisher<[ArtworkBrief], Error> {
        Just([ArtworkBrief.dummyData.first!])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
