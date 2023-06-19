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
    
    func test_onError_showsAlertWithErrorMessage() {
        let loader = ArtworkBriefLoaderSpy()
        loader.stubbedError = ArtworkAPIError.unauthorized
        let sut = makeSUT(artworkBriefLoader: loader)
        
        XCTAssertEqual(sut.isShowingErrorAlert.0, true)
    }
    
    func test_onEmptyBriefArray_showsAlertWithErrorMessage() {
        let loader = ArtworkBriefLoaderSpy()
        loader.stubbedBriefs = []
        let sut = makeSUT(artworkBriefLoader: loader)
        
        XCTAssertEqual(sut.isShowingNoResultsAlert, true)
    }
    
    func test_onNonEmptyBriefArray_doesntShowErrorAlerts() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.isShowingErrorAlert.0, false)
        XCTAssertEqual(sut.isShowingErrorAlert.1, nil)
        XCTAssertEqual(sut.isShowingNoResultsAlert, false)
    }
        
    // Helpers:
    
    private func makeSUT(artworkBriefLoader: any ArtworkBriefLoader = ArtworkBriefLoaderSpy(),
                         searchQuery: String = "anything",
                         briefTapAction: @escaping (ArtworkBrief) -> Void = { _ in }) -> ArtworkBriefListViewModel {
        return ArtworkBriefListViewModel(artworkBriefLoader: artworkBriefLoader, searchQuery: searchQuery, briefTapAction: briefTapAction)
    }

    
    private class ArtworkBriefLoaderSpy: ArtworkBriefLoader {
        var stubbedError: Error?
        var stubbedBriefs: [ArtworkBrief] = [ArtworkBrief.dummyData.first!]
        
        var loadedBriefsForQuery = Dictionary<String, [ArtworkBrief]>()
        
        func stubError(_ error: Error) {
            self.stubbedError = error
        }
        
        // Protocol methods:
         
        func loadBriefs(for query: String) -> AnyPublisher<[ArtGallery.ArtworkBrief], Error> {
            guard stubbedError == nil else {
                return Fail(error: stubbedError!)
                    .eraseToAnyPublisher()
            }
            self.loadedBriefsForQuery[query] = stubbedBriefs
            return Just(stubbedBriefs)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
