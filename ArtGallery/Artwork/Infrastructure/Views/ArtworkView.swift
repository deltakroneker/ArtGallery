//
//  ArtworkView.swift
//  ArtGallery
//
//  Created by nikolamilic on 6/7/23.
//

import SwiftUI
import Kingfisher

struct ArtworkView: View {
    var viewModel: ArtworkViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.subtitle)
                .font(.subheadline)
            
            KFImage(viewModel.imageURL)
                .placeholder {
                    ProgressView()
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
                .clipped()
            
            Text(viewModel.description)
                .font(.caption)
            
            Spacer()
        }
        .navigationTitle(viewModel.title)
    }
}

struct ArtworkView_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkView(viewModel: ArtworkViewModel(artwork: Artwork.dummyData.first!))
    }
}
