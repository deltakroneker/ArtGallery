//
//  iOSSwiftUIViewControllerFactoryTest.swift
//  ArtGalleryTests
//
//  Created by nikolamilic on 6/7/23.
//

import XCTest
import SwiftUI
@testable import ArtGallery

final class iOSSwiftUIViewControllerFactoryTest: XCTestCase {
 
    func test_searchViewController_createsControllerWithArtworkBriefSearchViewRootView() {
        let sut = iOSSwiftUIViewControllerFactory()
        let controller = sut.searchViewController(briefsLoadedAction: { _,_ in }) as? UIHostingController<ArtworkBriefSearchView>
        
        XCTAssertNotNil(controller)
    }
    
    func test_listViewController_createsControllerWithArtworkBriefListViewRootView() {
        let sut = iOSSwiftUIViewControllerFactory()
        let query = "query"
        let briefs = ArtworkBrief.dummyData
        let controller = sut.briefListViewController(searchQuery: query, briefs: briefs, briefTapAction: { _ in}) as? UIHostingController<ArtworkBriefListView>
        
        XCTAssertNotNil(controller)
        XCTAssertEqual(controller?.rootView.viewModel.briefs, briefs)
        XCTAssertEqual(controller?.rootView.viewModel.searchQuery, query)
    }
    
    func test_detailViewController_createsControllerWithArtworkViewRootView() {
        let sut = iOSSwiftUIViewControllerFactory()
        let controller = sut.detailViewController() as? UIHostingController<ArtworkView>
        
        XCTAssertNotNil(controller)
    }
}
