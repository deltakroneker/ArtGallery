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
    
    func test_onSearchScreenBriefsLoadedAction_showsListViewController() {
        let searchVC = UIViewController()
        let listVC = UIViewController()
        let query = "query"
        let briefs = [ArtworkBrief]()
        factory.stubSearchVC(with: searchVC)
        factory.stubListVC(searchQuery: query, briefs: briefs, with: listVC)
        let sut = NavigationControllerRouter(navigationController, factory: self.factory, dispatchQueue: self.dispatchQueue)
        
        sut.start()
        factory.briefsLoadedAction?(query, briefs)
        
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
        var briefsLoadedAction: ((String, [ArtworkBrief]) -> Void)?
        
        private var stubbedListVCs = Dictionary<String, ([ArtworkBrief], UIViewController)>()

        func stubSearchVC(with viewController: UIViewController) {
            stubbedSearchVC = viewController
        }

        func stubListVC(searchQuery: String, briefs: [ArtworkBrief], with viewController: UIViewController) {
            stubbedListVCs[searchQuery] = (briefs, viewController)
        }
        
        // Factory protocol:
        
        func searchViewController(briefsLoadedAction: @escaping (String, [ArtGallery.ArtworkBrief]) -> Void) -> UIViewController {
            self.briefsLoadedAction = briefsLoadedAction
            return stubbedSearchVC ?? UIViewController()
        }
        
        func briefListViewController(searchQuery: String, briefs: [ArtGallery.ArtworkBrief], briefTapAction: @escaping (ArtGallery.Artwork) -> Void) -> UIViewController {
            return stubbedListVCs[searchQuery]?.1 ?? UIViewController()
        }

        func detailViewController(artwork: ArtGallery.Artwork) -> UIViewController {
            return UIViewController()
        }
    }
}
