//
//  RemoteArtworkBriefLoader.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/16/23.
//

import Foundation
import Combine

class RemoteArtworkBriefLoader: ArtworkBriefLoader {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func loadBriefs(for query: String) -> AnyPublisher<[ArtworkBrief], Error> {
        let params = CollectionParams(q: query, p: 0, ps: 10)
        return self.client.publisher(request: ArtworkRequestProvider.collection(params).makeRequest)
            .tryMap(ArtworkMapper.mapArtworkBrief)
            .map({ dtos in
                dtos.map { dto in
                    ArtworkBrief(id: dto.id,
                                 objectNumber: dto.objectNumber,
                                 title: dto.title,
                                 principalOrFirstMaker: dto.principalOrFirstMaker,
                                 headerImageURLString: dto.headerImage.url)
                }
            })
            .eraseToAnyPublisher()
    }
}
