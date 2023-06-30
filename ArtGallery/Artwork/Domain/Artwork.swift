//
//  Artwork.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/9/23.
//

import Foundation

struct Artwork {
    var id: String
    let title: String
    let description: String?
    let date: String
    
    let physicalMedium: String
    
    let principalMaker: String
    let makerLine: String?
    
    let webImageURLString: String?
    let localImageData: Data?
}
