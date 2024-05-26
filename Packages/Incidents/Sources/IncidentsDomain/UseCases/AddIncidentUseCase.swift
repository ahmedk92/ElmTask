public final class AddIncidentUseCase {
    private let repository: Repository
    
    public init(repository: Repository) {
        self.repository = repository
    }
    
    public func callAsFunction(request: AddIncidentRequest) async throws {
        try await repository.addIncident(request: request)
    }
}

extension AddIncidentUseCase {
    public protocol Repository {
        func addIncident(request: AddIncidentRequest) async throws
    }
}
