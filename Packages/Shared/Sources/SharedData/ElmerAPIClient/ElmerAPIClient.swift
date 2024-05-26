import Foundation

private let EXPECTED_LOGIN_RESPONSE = "OK"

public protocol ElmerAPIClientProtocol {
    func login(email: String) async throws
    func verify(email: String, otp: String) async throws -> ElmerAPIToken
    func incidents() async throws -> [Incident]
}

public final class ElmerAPIClient: ElmerAPIClientProtocol {
    private let urlSession: URLSession
    private let requestFactory: ElmerAPIRequestFactoryProtocol
    
    public init(
        urlSession: URLSession,
        requestFactory: ElmerAPIRequestFactoryProtocol
    ) {
        self.urlSession = urlSession
        self.requestFactory = requestFactory
    }
    
    public func login(email: String) async throws {
        let request = try requestFactory.makeLoginRequest(
            email: email
        )
        let (data, _) = try await urlSession.data(
            for: request
        )
        
        guard 
            let stringResponse = String(data: data, encoding: .utf8)
        else {
            throw Error.unexpectedLoginResponseError(
                expectedLoginResponse: EXPECTED_LOGIN_RESPONSE,
                actualLoginResponse: nil
            )
        }
        
        if stringResponse != "OK" {
            throw Error.unexpectedLoginResponseError(
                expectedLoginResponse: EXPECTED_LOGIN_RESPONSE,
                actualLoginResponse: stringResponse
            )
        }
    }
    
    public func verify(
        email: String,
        otp: String
    ) async throws -> ElmerAPIToken {
        let request = try requestFactory.makeVerifyOTPRequest(
            email: email,
            otp: otp
        )
        
        let token: ElmerAPIToken = try await urlSession.json(for: request)
        return token
    }
    
    public func incidents() async throws -> [Incident] {
        let request = try await requestFactory.makeGetIncidentsRequest()
        struct Response: Decodable {
            let incidents: [Incident]
        }
        let response: Response = try await urlSession.json(for: request)
        return response.incidents
    }
}

extension ElmerAPIClient {
    public enum Error: Swift.Error {
        case unexpectedLoginResponseError(
            expectedLoginResponse: String,
            actualLoginResponse: String?
        )
    }
}

private extension URLSession {
    func json<T: Decodable>(for request: URLRequest) async throws -> T {
        let (data, _) = try await data(for: request)
        let json = try JSONDecoder().decode(T.self, from: data)
        return json
    }
}
