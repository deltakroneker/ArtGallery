//
//  ArtworkViewModel.swift
//  ArtGallery
//
//  Created by nikolamilic on 6/7/23.
//

import Foundation

struct ArtworkViewModel {
    let title: String
    let subtitle: String
    let description: String
    let imageURLString: String?
    
    var imageURL: URL? { (imageURLString != nil) ? URL(string: imageURLString!) : nil }
    
    init(artwork: Artwork) {
        self.title = artwork.title
        self.subtitle = artwork.principalMaker
        self.description = artwork.description ?? "No description"
        self.imageURLString = artwork.webImageURLString
    }
}
