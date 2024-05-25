//
//  AppDelegate.swift
//  ElmTask
//
//  Created by Ahmed Khalaf on 25/05/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private lazy var appCoordinator: AppCoordinator = .init(
        viewControllerFactory: AppCoordinatorViewControllerFactory()
    )

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appCoordinator.start(in: &window)
        return true
    }
}
