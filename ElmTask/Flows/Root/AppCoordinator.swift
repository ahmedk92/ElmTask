import UIKit
import Authentication

@MainActor
final class AppCoordinator {
    private let appDIContainer: AppDIContainer = .init()
    private lazy var viewControllerFactory:
    AppCoordinatorViewControllerFactory = .init(
        authenticationDIContainer: appDIContainer.authenticationDIContainer,
        incidentsDIContainer: appDIContainer.incidentsDIContainer,
        executeAsync: { asyncClosure in
            Task { try await asyncClosure() }
        }
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
            showIncidentsListScreen()
        case .loggedOut:
            showLoginScreen()
        }
    }
    
    private func showLoginScreen() {
        let loginViewController = viewControllerFactory.makeLoginViewController(
            onLoginSuccess: { [weak self] email in
                self?.showVerifyOTPScreen(email: email)
            }
        )
        
        navigationController?.setViewControllers([loginViewController], animated: true)
    }
    
    private func showVerifyOTPScreen(email: String) {
        let viewController = viewControllerFactory.makeVerifyOTPViewController(
            email: email,
            onVerificationSuccess: { [weak self] in
                self?.showIncidentsListScreen()
            }
        )
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func showIncidentsListScreen() {
        let viewController = viewControllerFactory.makeIncidentsViewController()
        navigationController?.setViewControllers([viewController], animated: true)
    }
}
