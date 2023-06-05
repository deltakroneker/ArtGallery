//
//  ArtworkBriefItemView.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/16/23.
//

import SwiftUI
import Kingfisher

struct ArtworkBriefItemView: View {
    let viewModel: ArtworkBriefItemViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            KFImage(viewModel.imageURL)
                .placeholder {
                    Image(systemName: "paintbrush.pointed.fill")
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100)
                .clipped()
            
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .font(.headline)
                    .lineLimit(2)
                Text(viewModel.author)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
        }
        .frame(height: 65)
        .contentShape(Rectangle())
    }
}

struct ArtworkBriefItemView_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkBriefItemView(viewModel: ArtworkBriefItemViewModel(artworkBrief: ArtworkBrief.dummyData.first!))
            .previewLayout(.sizeThatFits)
    }
}
