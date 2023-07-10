//
//  ArtworkBriefDTO.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/9/23.
//

import Foundation

// Artwork brief

struct ArtworkBriefContainerDTO: Codable {
    let count: Int
    let artObjects: [ArtworkBriefDTO]
}

struct ArtworkBriefDTO: Codable {
    let id: String
    let objectNumber: String
    let title: String
    let principalOrFirstMaker: String
    let headerImage: ArtworkImage
}

struct ArtworkImage: Codable {
    let width: Double
    let height: Double
    let url: String
}

// Artwork

struct ArtworkContainerDTO: Codable {
    let artObject: ArtworkDTO
}

struct ArtworkDTO: Codable {
    let id: String
    let title: String
    let description: String?
    let physicalMedium: String
    let principalMaker: String
    let dating: ArtworkDating
    let label: ArtworkLabel
    let webImage: ArtworkImage?
}

struct ArtworkDating: Codable {
    let presentingDate: String
}

struct ArtworkLabel: Codable {
    let makerLine: String?
}
