public protocol ElmerAPIAccessTokenAccessor {
    func accessToken() async throws -> String?
}
