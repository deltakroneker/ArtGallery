//
//  ArtworkAPIErrors.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/10/23.
//

import Foundation

enum ArtworkAPIError: Error {
    case unauthorized
    case emptyErrorWithStatusCode(String)
}
