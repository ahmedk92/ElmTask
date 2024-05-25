public final class VerifyOTPUseCase {
    private let repository: Repository
    
    public init(repository: Repository) {
        self.repository = repository
    }
    
    public func callAsFunction(email: String, otp: String) async throws {
        try await repository.verify(email: email, otp: otp)
    }
}

extension VerifyOTPUseCase {
    public protocol Repository {
        func verify(email: String, otp: String) async throws
    }
}
