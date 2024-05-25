import UIKit
import Authentication

@MainActor
final class AppCoordinatorViewControllerFactory {
    private let authenticationDIContainer: AuthenticationDIContainer
    private let executeAsync: (@escaping () async throws -> Void) -> Void
    
    init(
        authenticationDIContainer: AuthenticationDIContainer,
        executeAsync: @escaping (@escaping () async throws -> Void) -> Void
    ) {
        self.authenticationDIContainer = authenticationDIContainer
        self.executeAsync = executeAsync
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
        onLoginSuccess: @escaping (String) -> Void
    ) -> LoginViewController {
        .init(
            viewModel: .init(
                loginUseCase: authenticationDIContainer.makeLoginUseCase(),
                validateEmailUseCase: authenticationDIContainer.makeValidateEmailUseCase()
            ),
            onLoginSuccess: onLoginSuccess
        )
    }
    
    func makeVerifyOTPViewController(
        email: String,
        onVerificationSuccess: @escaping () -> Void
    ) -> VerifyOTPViewController {
        .init(
            viewModel: .init(
                email: email,
                verifyOTPUseCase: authenticationDIContainer.makeVerifyOTPUseCase(),
                executeAsync: executeAsync
            ),
            onVerificationSuccess: onVerificationSuccess
        )
    }
}
