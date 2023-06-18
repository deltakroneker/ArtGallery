//
//  ArtworkViewModelTest.swift
//  ArtGalleryTests
//
//  Created by nikolamilic on 6/18/23.
//

import XCTest
import Combine
@testable import ArtGallery

final class ArtworkViewModelTest: XCTestCase {
    func test_afterInit_triggersLoaderWithCorrectBrief() {
        let loader = ArtworkLoaderSpy()
        let brief = ArtworkBrief.dummyData.first!
        let sut = makeSUT(artworkLoader: loader, artworkBrief: brief)
        
        XCTAssertEqual(brief.objectNumber, loader.loadedArtworkObjectNumbers.first!)
    }
    
    // Helpers:
    
    private func makeSUT(artworkLoader: ArtworkLoader = ArtworkLoaderSpy(), artworkBrief: ArtworkBrief = ArtworkBrief.dummyData.first!) -> ArtworkViewModel {
        return ArtworkViewModel(artworkLoader: artworkLoader, artworkBrief: artworkBrief)
    }
    
    private class ArtworkLoaderSpy: ArtworkLoader {
        var loadedArtworkObjectNumbers = [String]()

        func loadArtwork(for objectNumber: String) -> AnyPublisher<ArtGallery.Artwork, Error> {
            let result = Artwork.dummyData.first!
            self.loadedArtworkObjectNumbers.append(objectNumber)
            return Just(result)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
