//
//  ArtworkBriefItemView.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/16/23.
//

import SwiftUI

struct ArtworkBriefItemView: View {
    
    let viewModel: ArtworkBriefItemViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "paintbrush.pointed.fill")
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .bold()
                Text(viewModel.author)
                    .font(.subheadline)
            }
        }
        .contentShape(Rectangle())
    }
}

struct ArtworkBriefItemView_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkBriefItemView(viewModel: ArtworkBriefItemViewModel(artworkBrief: ArtworkBrief.dummyData.first!))
            .previewLayout(.sizeThatFits)
    }
}
