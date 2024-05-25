import AuthenticationDomain

public class AuthenticationRepository: 
    GetAuthenticationStateUseCase.Repository,
    LoginUseCase.Repository,
    VerifyOTPUseCase.Repository {
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
        authenticationStateDataSource.authenticationState()
    }
    
    public func login(email: String) async throws {
        try await elmerAPIClient.login(email: email)
    }
    
    public func verify(email: String, otp: String) async throws {
        let authToken = try await elmerAPIClient.verify(email: email, otp: otp)
        authenticationStateDataSource.save(authToken: authToken.token)
    }
}
