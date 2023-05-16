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
        List {
            ForEach(viewModel.briefs) {
                Text($0.title)
            }
        }
    }
}

struct ArtworkBriefListView_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkBriefListView(viewModel: ArtworkBriefListViewModel(briefs: ArtworkBrief.dummyData, briefTapAction: { _ in }))
    }
}
