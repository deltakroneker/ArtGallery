//
//  ArtworkLoader.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/9/23.
//

import Foundation

protocol ArtworkLoader {
    func load() async -> Result<[Artwork], Error>
}
