//
//  AppCoordinator.swift
//  ElmTask
//
//  Created by Ahmed Khalaf on 25/05/2024.
//

import UIKit

final class AppCoordinator: NSObject, RootViewController.Delegate {
    private let viewControllerFactory: ViewControllerFactory
    
    init(viewControllerFactory: ViewControllerFactory) {
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start(in window: inout UIWindow?) {
        let rootViewController = viewControllerFactory.makeRootViewController()
        rootViewController.delegate = self
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    func rootViewController(
        _ rootViewController: AppCoordinator,
        didReceiveAuthenticationStateChangeEvent: Any
    ) {
        
    }
}

extension AppCoordinator {
    protocol ViewControllerFactory {
        func makeRootViewController() -> RootViewController
    }
}
