import AuthenticationDomain
import AuthenticationUI
import AuthenticationData
import Foundation

public final class AuthenticationDIContainer {
    private let userDefaults: UserDefaults
    private let urlSession: URLSession
    
    private lazy var authenticationStateDataSource: AuthenticationStateDataSourceProtocol = AuthenticationStateDataSource(
        userDefaults: userDefaults
    )
    
    private lazy var elmerAPIClient: ElmerAPIClientProtocol = ElmerAPIClient(
        urlSession: urlSession
    )
    
    private lazy var authenticationRepository: AuthenticationRepository = .init(
        authenticationStateDataSource: authenticationStateDataSource,
        elmerAPIClient: elmerAPIClient
    )
    
    public init(
        userDefaults: UserDefaults,
        urlSession: URLSession
    ) {
        self.userDefaults = userDefaults
        self.urlSession = urlSession
    }
    
    public func makeGetAuthenticationStateUseCase(
    ) -> GetAuthenticationStateUseCase {
        .init(repository: authenticationRepository)
    }
    
    public func makeValidateEmailUseCase() -> ValidateEmailUseCase {
        .init(emailValidator: EmailValidator())
    }
    
    public func makeLoginUseCase() -> LoginUseCase {
        .init(repository: authenticationRepository)
    }
    
    public func makeVerifyOTPUseCase() -> VerifyOTPUseCase {
        .init(repository: authenticationRepository)
    }
}
