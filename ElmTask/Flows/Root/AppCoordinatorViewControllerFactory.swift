import UIKit
import Authentication

final class AppCoordinatorViewControllerFactory: AppCoordinator.ViewControllerFactory {
    func makeRootViewController(
        onAuthenticationStateChanged: @escaping (AuthenticationState) -> Void
    ) -> RootViewController {
        .init(
            viewModel: .init(
                getAuthenticationStateUseCase: .init(
                    repository: MockAuthenticationRepository()
                )
            ),
            onAuthenticationStateChanged: onAuthenticationStateChanged
        )
    }
}

private class MockAuthenticationRepository: GetAuthenticationStateUseCase.Repository {
    func authenticationState() async throws -> AuthenticationState {
        .loggedOut
    }
    
}
