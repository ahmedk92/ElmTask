import IncidentsDomain
import SharedData

public final class IncidentsRepository: GetIncidentsUseCase.Repository,
                                        AddIncidentUseCase.Repository {
    private let elmerAPIClient: ElmerAPIClientProtocol
    
    public init(elmerAPIClient: ElmerAPIClientProtocol) {
        self.elmerAPIClient = elmerAPIClient
    }
    
    public func incidents() async throws -> [IncidentsDomain.Incident] {
        try await elmerAPIClient
            .incidents()
            .map(IncidentsDomain.Incident.init(incident:))
    }
    
    public func addIncident(request: AddIncidentRequest) async throws {
        
    }
}

