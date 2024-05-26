import IncidentsDomain
import IncidentsUI
import IncidentsData
import SharedData

public final class IncidentsDIContainer {
    private let elmerAPIClient: ElmerAPIClientProtocol
    
    private lazy var incidentsRepository: IncidentsRepository = .init(
        elmerAPIClient: elmerAPIClient
    )
    
    public init(
        elmerAPIClient: ElmerAPIClientProtocol
    ) {
        self.elmerAPIClient = elmerAPIClient
    }
    
    public func makeGetIncidentsUseCase() -> GetIncidentsUseCase {
        .init(repository: incidentsRepository)
    }
    
    public func makeAddIncidentUseCase() -> AddIncidentUseCase {
        .init(repository: incidentsRepository)
    }
}
