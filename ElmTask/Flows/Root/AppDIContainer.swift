import Authentication

final class AppDIContainer {
    func makeAuthenticationDIContainer() -> AuthenticationDIContainer {
        .init(
            userDefaults: .standard,
            urlSession: .shared
        )
    }
}
