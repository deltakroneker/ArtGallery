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
    
    func test_afterInit_performSearchCallDoesNotTriggerAction() {
        var called = false
        let sut = makeSUT(searchButtonAction: { _ in called = true })
        
        sut.performSearch()

        XCTAssertFalse(called)
    }
    
    func test_withQuery_actionIsCalledWithCorrectQuery() {
        var actionsCalled = [String]()
        let sut = makeSUT(searchButtonAction: { query in actionsCalled.append(query) })
        
        sut.queryText = "first"
        sut.performSearch()
        sut.queryText = "second"
        sut.performSearch()
        
        XCTAssertEqual(actionsCalled, ["first", "second"])
    }
    
    // Helpers:
    
    private func makeSUT(searchButtonAction: @escaping (String) -> Void = { _ in }) -> ArtworkBriefSearchViewModel {
        return ArtworkBriefSearchViewModel(searchButtonAction: searchButtonAction)
    }
}
