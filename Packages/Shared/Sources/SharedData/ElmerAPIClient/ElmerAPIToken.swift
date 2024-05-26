public struct ElmerAPIToken: Decodable {
    public let token: String
    
    public init(token: String) {
        self.token = token
    }
}
