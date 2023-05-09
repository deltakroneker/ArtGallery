//
//  AppDelegate.swift
//  ArtGallery
//
//  Created by nikolamilic on 5/9/23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private lazy var navigationController = UINavigationController()
    private var router: NavigationControllerRouter!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        router = NavigationControllerRouter(navigationController, factory: iOSSwiftUIViewControllerFactory())
        router.start()
        
        return true
    }
}
