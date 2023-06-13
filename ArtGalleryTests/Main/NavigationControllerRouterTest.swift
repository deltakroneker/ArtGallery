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

        func stubSearchVC(with viewController: UIViewController) {
            stubbedSearchVC = viewController
        }

        func stubListVC(searchQuery: String, with viewController: UIViewController) {
            stubbedListVCs[searchQuery] = viewController
        }
        
        // Factory protocol:
        
        func searchViewController(searchButtonAction: @escaping (String) -> Void) -> UIViewController {
            self.searchButtonAction = searchButtonAction
            return stubbedSearchVC ?? UIViewController()
        }
        
        func briefListViewController(searchQuery: String, briefTapAction: @escaping (ArtGallery.ArtworkBrief) -> Void) -> UIViewController {
            return stubbedListVCs[searchQuery] ?? UIViewController()
        }

        func detailViewController(artworkBrief: ArtGallery.ArtworkBrief) -> UIViewController {
            return UIViewController()
        }
    }
}
