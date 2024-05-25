import AuthenticationDomain

public class AuthenticationRepository: 
    GetAuthenticationStateUseCase.Repository,
    LoginUseCase.Repository {
    private let authenticationStateDataSource: AuthenticationStateDataSourceProtocol
    private let elmerAPIClient: ElmerAPIClientProtocol
    
    public init(
        authenticationStateDataSource: AuthenticationStateDataSourceProtocol,
        elmerAPIClient: ElmerAPIClientProtocol
    ) {
        self.authenticationStateDataSource = authenticationStateDataSource
        self.elmerAPIClient = elmerAPIClient
    }
    
    public func authenticationState() async throws -> AuthenticationState {
        try await authenticationStateDataSource.authenticationState()
    }
    
    public func login(email: String) async throws {
        try await elmerAPIClient.login(email: email)
    }
}
