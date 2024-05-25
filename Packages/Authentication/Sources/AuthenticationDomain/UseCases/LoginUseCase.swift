public final class LoginUseCase {
    private let repository: Repository
    
    public init(repository: Repository) {
        self.repository = repository
    }
    
    public func callAsFunction(email: String) async throws {
        try await repository.login(email: email)
    }
}

extension LoginUseCase {
    public protocol Repository {
        func login(email: String) async throws
    }
}
