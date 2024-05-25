import AuthenticationDomain
import Foundation

public protocol AuthenticationStateDataSourceProtocol {
    func authenticationState() -> AuthenticationState
    func save(authToken: String)
}

public class AuthenticationStateDataSource: AuthenticationStateDataSourceProtocol {
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
}

private enum UserDefaultsKeys {
    static let authToken = "auth_token"
}

private extension String {
    var nilIfEmpty: String? {
        isEmpty ? nil : self
    }
}
