import UIKit
import Authentication

@MainActor
final class AppCoordinatorViewControllerFactory {
    private let authenticationDIContainer: AuthenticationDIContainer
    
    init(authenticationDIContainer: AuthenticationDIContainer) {
        self.authenticationDIContainer = authenticationDIContainer
    }
    
    func makeRootViewController(
        onAuthenticationStateChanged: @escaping (AuthenticationState) -> Void
    ) -> RootViewController {
        .init(
            viewModel: .init(
                getAuthenticationStateUseCase: authenticationDIContainer
                    .makeGetAuthenticationStateUseCase()
            ),
            onAuthenticationStateChanged: onAuthenticationStateChanged
        )
    }
    
    func makeLoginViewController(
        onLoginSuccess: @escaping () -> Void
    ) -> LoginViewController {
        .init(
            viewModel: .init(
                loginUseCase: authenticationDIContainer.makeLoginUseCase(),
                validateEmailUseCase: authenticationDIContainer.makeValidateEmailUseCase()
            ),
            onLoginSuccess: onLoginSuccess
        )
    }
}
