//
//  NavigationControllerRouterTest.swift
//  ArtGalleryTests
//
//  Created by nikolamilic on 6/5/23.
//

import XCTest
@testable import ArtGallery

final class NavigationControllerRouterTest: XCTestCase {
    
    func test_onStart_showsSearchViewController() {
        let searchVC = UIViewController()
        factory.stubSearchVC(with: searchVC)
        let sut = NavigationControllerRouter(navigationController, factory: self.factory, dispatchQueue: self.dispatchQueue)
        
        sut.start()
        
        XCTAssertEqual(navigationController.viewControllers, [searchVC])
    }
    
    func test_onSearchScreenSearchButtonAction_showsListViewController() {
        let searchVC = UIViewController()
        let listVC = UIViewController()
        let query = "query"
        factory.stubSearchVC(with: searchVC)
        factory.stubListVC(searchQuery: query, with: listVC)
        let sut = NavigationControllerRouter(navigationController, factory: self.factory, dispatchQueue: self.dispatchQueue)
        
        sut.start()
        factory.searchButtonAction?(query)
        
        XCTAssertEqual(navigationController.viewControllers, [searchVC, listVC])
    }
    
    func test_onListScreenBriefTapAction_showsArtworkDetailsViewController() {
        let searchVC = UIViewController()
        let listVC = UIViewController()
        let detailsVC = UIViewController()
        let query = "query"
        let brief = ArtworkBrief.dummyData.first!
        factory.stubSearchVC(with: searchVC)
        factory.stubListVC(searchQuery: query, with: listVC)
        factory.stubDetailsVC(objectNumber: brief.objectNumber, with: detailsVC)
        let sut = NavigationControllerRouter(navigationController, factory: self.factory, dispatchQueue: self.dispatchQueue)
        
        sut.start()
        factory.searchButtonAction?(query)
        factory.briefTapAction?(brief)
        
        XCTAssertEqual(navigationController.viewControllers, [searchVC, listVC, detailsVC])
    }
    
    // Helpers:
    
    private let factory = ViewControllerFactoryStub()
    private let navigationController = NonAnimatedNavigationController()
    private let dispatchQueue = DispatchFake()
    
    private class NonAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    private class DispatchFake: Dispatching {
        func async(execute workItem: DispatchWorkItem) {
            workItem.perform()
        }
    }
    
    private class ViewControllerFactoryStub: ViewControllerFactory {
        private var stubbedSearchVC: UIViewController?
        var searchButtonAction: ((String) -> Void)?
        
        private var stubbedListVCs = Dictionary<String, UIViewController>()
        var briefTapAction: ((ArtworkBrief) -> Void)?
        
        private var stubbedDetailsVCs = Dictionary<String, UIViewController>()

        func stubSearchVC(with viewController: UIViewController) {
            stubbedSearchVC = viewController
        }

        func stubListVC(searchQuery: String, with viewController: UIViewController) {
            stubbedListVCs[searchQuery] = viewController
        }
        
        func stubDetailsVC(objectNumber: String, with viewController: UIViewController) {
            stubbedDetailsVCs[objectNumber] = viewController
        }
        
        // Factory protocol:
        
        func searchViewController(searchButtonAction: @escaping (String) -> Void) -> UIViewController {
            self.searchButtonAction = searchButtonAction
            return stubbedSearchVC ?? UIViewController()
        }
        
        func briefListViewController(searchQuery: String, briefTapAction: @escaping (ArtGallery.ArtworkBrief) -> Void) -> UIViewController {
            self.briefTapAction = briefTapAction
            return stubbedListVCs[searchQuery] ?? UIViewController()
        }

        func detailViewController(artworkBrief: ArtGallery.ArtworkBrief) -> UIViewController {
            return stubbedDetailsVCs[artworkBrief.objectNumber] ?? UIViewController()
        }
    }
}
