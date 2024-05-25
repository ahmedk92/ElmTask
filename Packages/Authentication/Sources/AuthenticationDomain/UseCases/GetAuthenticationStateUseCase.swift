public final class GetAuthenticationStateUseCase {
    private let repository: Repository
    
    public init(repository: Repository) {
        self.repository = repository
    }
    
    public func callAsFunction() async throws -> AuthenticationState {
        try await repository.authenticationState()
    }
}

extension GetAuthenticationStateUseCase {
    public protocol Repository {
        func authenticationState() async throws -> AuthenticationState
    }
}
