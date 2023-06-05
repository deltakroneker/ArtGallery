//
//  ArtworkBriefSearchViewModelTest.swift
//  ArtGalleryTests
//
//  Created by nikolamilic on 5/19/23.
//

import XCTest
import Combine
@testable import ArtGallery

final class ArtworkBriefSearchViewModelTest: XCTestCase {
    func test_afterInit_performSearchIsDisabled() {
        XCTAssertTrue(makeSUT().isPerformSearchDisabled)
    }
    
    func test_afterInit_performSearchCallDoesNotTriggerLoader() {
        let loader = ArtworkBriefLoaderSpy()

        makeSUT(loader: loader).performSearch()
        
        XCTAssertEqual(loader.loadedBriefsForQuery.count, 0)
    }
    
    func test_withQuery_performSearchCallTriggersLoader() {
        let loader = ArtworkBriefLoaderSpy()
        let sut = makeSUT(loader: loader)
        
        sut.queryText = "query"
        sut.performSearch()
        
        XCTAssertEqual(loader.loadedBriefsForQuery.count, 1)
    }
    
    func test_withLoadedBriefs_actionIsCalledWithSameBriefs() {
        var actionsCalled = Dictionary<String, [ArtworkBrief]>()
        let loader = ArtworkBriefLoaderSpy()
        let sut = makeSUT(loader: loader, briefsLoadedAction: { (query, briefs) in actionsCalled[query] = briefs
        })
        
        sut.queryText = "first"
        sut.performSearch()
        sut.queryText = "second"
        sut.performSearch()
        
        XCTAssertEqual(actionsCalled, loader.loadedBriefsForQuery)
    }
    
    // Helpers:
    
    private func makeSUT(loader: ArtworkBriefLoader = ArtworkBriefLoaderSpy(),
                         briefsLoadedAction: @escaping (String, [ArtworkBrief]) -> Void = { _, _ in }) -> ArtworkBriefSearchViewModel {
        return ArtworkBriefSearchViewModel(
            artworkBriefLoader: loader,
            briefsLoadedAction: briefsLoadedAction)
    }
    
    class ArtworkBriefLoaderSpy: ArtworkBriefLoader {
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
