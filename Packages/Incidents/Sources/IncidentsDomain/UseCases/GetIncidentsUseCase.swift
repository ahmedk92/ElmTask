public final class GetIncidentsUseCase {
    private let repository: Repository
    
    public init(repository: Repository) {
        self.repository = repository
    }
    
    public func callAsFunction() async throws -> [Incident] {
        try await repository.incidents()
    }
}

extension GetIncidentsUseCase {
    public protocol Repository {
        func incidents() async throws -> [Incident]
    }
}
