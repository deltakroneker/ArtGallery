//
//  ArtworkBriefListView.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/16/23.
//

import SwiftUI

struct ArtworkBriefListView: View {
    
    @ObservedObject var viewModel: ArtworkBriefListViewModel
    
    init(viewModel: ArtworkBriefListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.briefs) {
                    ArtworkBriefItemView(viewModel: ArtworkBriefItemViewModel(artworkBrief: $0))
                }
            }
            .navigationTitle("\"\(viewModel.searchQuery)\"")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ArtworkBriefListView_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkBriefListView(viewModel: ArtworkBriefListViewModel(searchQuery: "van gogh", briefs: ArtworkBrief.dummyData, briefTapAction: { _ in }))
    }
}
