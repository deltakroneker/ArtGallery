//
//  Artwork.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/9/23.
//

import Foundation

struct Artwork {
    let title: String
    let description: String
    let date: String
    
    let physicalMedium: String
    
    let principalMaker: String
    let makerLine: String
}

struct ArtworkBrief {
    let id: String
    let objectNumber: String
    let title: String
    let principalOrFirstMaker: String
    let headerImageURLString: String
}
