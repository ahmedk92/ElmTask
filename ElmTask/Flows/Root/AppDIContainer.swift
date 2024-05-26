import Authentication
import Incidents
import SharedData

final class AppDIContainer {
    private lazy var elmerAPIClient: ElmerAPIClientProtocol = ElmerAPIClient(
        urlSession: .shared,
        requestFactory: ElmerAPIRequestFactory(
            accessTokenAccessor: ElmerAPIAccessTokenAccessorShim(appDIContainer: self)
        )
    )
    
    private(set) lazy var authenticationDIContainer: AuthenticationDIContainer = .init(
        userDefaults: .standard,
        elmerAPIClient: elmerAPIClient
    )
    
    private(set) lazy var incidentsDIContainer: IncidentsDIContainer = .init(
        elmerAPIClient: elmerAPIClient
    )
}

private class ElmerAPIAccessTokenAccessorShim: ElmerAPIAccessTokenAccessor {
    weak var appDIContainer: AppDIContainer?
    
    init(appDIContainer: AppDIContainer? = nil) {
        self.appDIContainer = appDIContainer
    }
    
    func accessToken() async throws -> String? {
        try await appDIContainer?.authenticationDIContainer.elmerAPIAccessTokenAccessor.accessToken()
    }
}
