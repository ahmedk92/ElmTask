import AuthenticationDomain
import Foundation
import SharedData

public protocol AuthenticationStateDataSourceProtocol {
    func authenticationState() -> AuthenticationState
    func save(authToken: String)
}

public class AuthenticationStateDataSource: AuthenticationStateDataSourceProtocol,
ElmerAPIAccessTokenAccessor {
    private let userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    public func authenticationState() -> AuthenticationState {
        let authToken = userDefaults.string(forKey: UserDefaultsKeys.authToken)
        if authToken?.nilIfEmpty == nil {
            return .loggedOut
        } else {
            return .loggedIn
        }
    }
    
    public func save(authToken: String) {
        userDefaults.set(authToken, forKey: UserDefaultsKeys.authToken)
    }
    
    public func accessToken() async throws -> String? {
        userDefaults.string(forKey: UserDefaultsKeys.authToken)
    }
}

private enum UserDefaultsKeys {
    static let authToken = "auth_token"
}

private extension String {
    var nilIfEmpty: String? {
        isEmpty ? nil : self
    }
}
