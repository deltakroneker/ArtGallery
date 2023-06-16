//
//  ArtworkBriefListViewModelTest.swift
//  ArtGalleryTests
//
//  Created by nikolamilic on 6/16/23.
//

import XCTest
import Combine
@testable import ArtGallery

final class ArtworkBriefListViewModelTest: XCTestCase {
    func test_afterInit_triggersLoaderWithCorrectQuery() {
        let query = "anything"
        let loader = ArtworkBriefLoaderSpy()
        let sut = makeSUT(artworkBriefLoader: loader, searchQuery: query)
        
        XCTAssertEqual(sut.searchQuery, query)
        XCTAssertEqual(sut.briefs, loader.loadedBriefsForQuery[query])
    }
    
    func test_onShowArtworkDetailsCall_triggersBriefTapActionWithCorrectBrief() {
        var calledBrief: ArtworkBrief?
        let tappedBrief = ArtworkBrief.dummyData.first!
        let sut = makeSUT(briefTapAction: { calledBrief = $0 })
        
        sut.showArtworkDetails(for: tappedBrief)
        
        XCTAssertEqual(calledBrief, tappedBrief)
    }
        
    // Helpers:
    
    private func makeSUT(artworkBriefLoader: any ArtworkBriefLoader = ArtworkBriefLoaderSpy(),
                         searchQuery: String = "anything",
                         briefTapAction: @escaping (ArtworkBrief) -> Void = { _ in }) -> ArtworkBriefListViewModel {
        return ArtworkBriefListViewModel(artworkBriefLoader: artworkBriefLoader, searchQuery: searchQuery, briefTapAction: briefTapAction)
    }

    
    private class ArtworkBriefLoaderSpy: ArtworkBriefLoader {
        var loadedBriefsForQuery = Dictionary<String, [ArtworkBrief]>()
        
        func loadBriefs(for query: String) -> AnyPublisher<[ArtGallery.ArtworkBrief], Error> {
            let results = [ArtworkBrief.dummyData.first!]
            self.loadedBriefsForQuery[query] = results
            return Just(results)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
