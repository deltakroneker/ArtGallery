//
//  ArtworkBriefLoader.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/16/23.
//

import Foundation
import Combine

protocol ArtworkBriefLoader {
    func loadBriefs(for query: String) -> AnyPublisher<[ArtworkBrief], Error>
}
