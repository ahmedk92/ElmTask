import UIKit
import Authentication

@MainActor
final class AppCoordinator {
    private let appDIContainer: AppDIContainer = .init()
    private lazy var viewControllerFactory: 
    AppCoordinatorViewControllerFactory = .init(
        authenticationDIContainer: appDIContainer.makeAuthenticationDIContainer()
    )
    private weak var navigationController: UINavigationController?
    
    func start(in window: inout UIWindow?) {
        let rootViewController = viewControllerFactory.makeRootViewController(
            onAuthenticationStateChanged: {
                [weak self] authenticationState in
                self?.handleAuthenticationStateChange(
                    authenticationState: authenticationState
                )
            }
        )
        
        let navigationController = UINavigationController(
            rootViewController: rootViewController
        )
        navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController = navigationController
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func handleAuthenticationStateChange(
        authenticationState: AuthenticationState
    ) {
        switch authenticationState {
        case .loggedIn:
            print("Should show incidents list screen")
        case .loggedOut:
            showLoginScreen()
        }
    }
    
    private func showLoginScreen() {
        let loginViewController = viewControllerFactory.makeLoginViewController(
            onLoginSuccess: { [weak self] in
                self?.showVerifyOTPScreen()
            }
        )
        
        navigationController?.setViewControllers([loginViewController], animated: true)
    }
    
    private func showVerifyOTPScreen() {
        print("Should show verify OTP screen")
    }
}
