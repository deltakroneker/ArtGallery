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
        let controller = sut.searchViewController(searchButtonAction: { _ in }) as? UIHostingController<ArtworkBriefSearchView>
        
        XCTAssertNotNil(controller)
    }
    
    func test_listViewController_createsControllerWithArtworkBriefListViewRootView() {
        let sut = iOSSwiftUIViewControllerFactory()
        let query = "query"
        let controller = sut.briefListViewController(searchQuery: query, briefTapAction: { _ in}) as? UIHostingController<ArtworkBriefListView>
        
        XCTAssertNotNil(controller)
        XCTAssertEqual(controller?.rootView.viewModel.searchQuery, query)
    }
    
    func test_detailViewController_createsControllerWithArtworkViewRootView() {
        let sut = iOSSwiftUIViewControllerFactory()
        let brief = ArtworkBrief.dummyData.first!
        let controller = sut.detailViewController(artworkBrief: brief) as? UIHostingController<ArtworkView>
        
        XCTAssertNotNil(controller)
    }
}
