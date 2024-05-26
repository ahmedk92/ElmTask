import AuthenticationDomain
import AuthenticationUI
import AuthenticationData
import Foundation
import SharedData

public final class AuthenticationDIContainer {
    private let userDefaults: UserDefaults
    private let elmerAPIClient: ElmerAPIClientProtocol
    
    private lazy var authenticationStateDataSource: AuthenticationStateDataSource = .init(
        userDefaults: userDefaults
    )
    
    private lazy var authenticationRepository: AuthenticationRepository = .init(
        authenticationStateDataSource: authenticationStateDataSource,
        elmerAPIClient: elmerAPIClient
    )
    
    public var elmerAPIAccessTokenAccessor: ElmerAPIAccessTokenAccessor {
        authenticationStateDataSource
    }
    
    public init(
        userDefaults: UserDefaults,
        elmerAPIClient: ElmerAPIClientProtocol
    ) {
        self.userDefaults = userDefaults
        self.elmerAPIClient = elmerAPIClient
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
