import UIKit
import Authentication

@MainActor
final class AppCoordinator {
    private let viewControllerFactory: ViewControllerFactory
    
    init(viewControllerFactory: ViewControllerFactory) {
        self.viewControllerFactory = viewControllerFactory
    }
    
    func start(in window: inout UIWindow?) {
        let rootViewController = viewControllerFactory.makeRootViewController(
            onAuthenticationStateChanged: {
                [weak self] authenticationState in
                self?.handleAuthenticationStateChange(
                    authenticationState: authenticationState
                )
            }
        )
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    private func handleAuthenticationStateChange(
        authenticationState: AuthenticationState
    ) {
        print("Should show login screen")
    }
}

extension AppCoordinator {
    
    @MainActor
    protocol ViewControllerFactory {
        func makeRootViewController(
            onAuthenticationStateChanged: @escaping (AuthenticationState) -> Void
        ) -> RootViewController
    }
}
