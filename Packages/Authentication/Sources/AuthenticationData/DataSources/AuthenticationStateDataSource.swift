import AuthenticationDomain
import Foundation

public protocol AuthenticationStateDataSourceProtocol {
    func authenticationState() async throws -> AuthenticationState
}

public class AuthenticationStateDataSource: AuthenticationStateDataSourceProtocol {
    private let userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    public func authenticationState() async throws -> AuthenticationState {
        userDefaults.bool(forKey: UserDefaultsKeys.isLoggedIn) ? .loggedIn : .loggedOut
    }
    
    public func set(authenticationState: AuthenticationState) {
        switch authenticationState {
        case .loggedIn:
            userDefaults.setValue(true, forKey: UserDefaultsKeys.isLoggedIn)
        case .loggedOut:
            userDefaults.setValue(false, forKey: UserDefaultsKeys.isLoggedIn)
        }
    }
}

private enum UserDefaultsKeys {
    static let isLoggedIn = "isLoggedIn"
}
