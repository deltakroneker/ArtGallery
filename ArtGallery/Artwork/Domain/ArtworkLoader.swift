//
//  ArtworkLoader.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/9/23.
//

import Foundation
import Combine

protocol ArtworkLoader {
    func loadArtwork(for objectNumber: String) -> AnyPublisher<Artwork, Error>
}
