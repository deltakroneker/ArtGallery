//
//  ArtworkMapper.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/9/23.
//

import Foundation

struct ArtworkMapper {
    static func mapArtworkBrief(data: Data, response: HTTPURLResponse) throws -> [ArtworkBriefDTO] {
        if (200..<300) ~= response.statusCode {
            return (try JSONDecoder().decode(ArtworkBriefContainerDTO.self, from: data)).artObjects
        } else if response.statusCode == 401 {
            throw ArtworkAPIError.unauthorized
        } else {
            throw ArtworkAPIError.emptyErrorWithStatusCode(response.statusCode.description)
        }
    }
    
    static func mapArtwork(data: Data, response: HTTPURLResponse) throws -> ArtworkDTO {
        if (200..<300) ~= response.statusCode {
            return (try JSONDecoder().decode(ArtworkContainerDTO.self, from: data)).artObject
        } else if response.statusCode == 401 {
            throw ArtworkAPIError.unauthorized
        } else {
            throw ArtworkAPIError.emptyErrorWithStatusCode(response.statusCode.description)
        }
    }
}
