//
//  Artwork+CoreDataPersistable.swift
//  ArtGallery
//
//  Created by nikolamilic on 6/30/23.
//

import CoreData

extension Artwork {
    init() {
        self.id = UUID().uuidString
        self.title = ""
        self.description = nil
        self.date = ""
        self.physicalMedium = ""
        self.principalMaker = ""
        self.makerLine = nil
        self.webImageURLString = nil
        self.localImageData = nil
    }
}

extension Artwork: CoreDataPersistable {
    typealias ManagedType = ArtworkEntity
    
    var keyMap: [PartialKeyPath<Artwork> : String] {
        [
            \.localImageData: "image",
            \.physicalMedium: "physicalMedium",
            \.principalMaker: "principalMaker",
            \.makerLine: "makerLine",
            \.date: "date",
            \.description: "desc",
            \.title: "title",
            \.id: "id"
        ]
    }
}
