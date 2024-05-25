//
//  AppCoordinatorViewControllerFactory.swift
//  ElmTask
//
//  Created by Ahmed Khalaf on 25/05/2024.
//

import UIKit

final class AppCoordinatorViewControllerFactory: AppCoordinator.ViewControllerFactory {
    func makeRootViewController() -> RootViewController {
        .init()
    }
}
