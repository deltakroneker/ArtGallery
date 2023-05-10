//
//  ArtworkLoader.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/9/23.
//

import Foundation
import Combine

protocol ArtworkLoader {
    func loadBriefs(for query: String) async -> AnyPublisher<[ArtworkBrief], Error>
    func loadArtwork(for id: String) async -> AnyPublisher<Artwork, Error>
}
