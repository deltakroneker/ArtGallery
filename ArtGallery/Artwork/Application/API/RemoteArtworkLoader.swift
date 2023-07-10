//
//  RemoteArtworkLoader.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/9/23.
//

import Foundation
import Combine

class RemoteArtworkLoader: ArtworkLoader {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }

    func loadArtwork(for objectNumber: String) -> AnyPublisher<Artwork, Error> {
        let params = ObjectParams(objectNumber)
        return self.client.publisher(request: ArtworkRequestProvider.object(params).makeRequest)
            .tryMap(ArtworkMapper.mapArtwork)
            .map({ dto in
                Artwork(id: dto.id,
                        title: dto.title,
                        description: dto.description,
                        date: dto.dating.presentingDate,
                        physicalMedium: dto.physicalMedium,
                        principalMaker: dto.principalMaker,
                        makerLine: dto.label.makerLine,
                        webImageURLString: dto.webImage?.url,
                        localImageData: nil)
            })
            .eraseToAnyPublisher()
    }
}
