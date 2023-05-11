//
//  ArtworkBriefItemViewModel.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/11/23.
//

import Foundation

struct ArtworkBriefItemViewModel {
    let id: String
    let title: String
    let author: String
    let imageURL: String
    
    init(artworkBrief: ArtworkBrief) {
        self.id = artworkBrief.id
        self.title = artworkBrief.title
        self.author = artworkBrief.principalOrFirstMaker
        self.imageURL = artworkBrief.headerImageURLString
    }
}
