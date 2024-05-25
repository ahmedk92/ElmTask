import Foundation

private let EXPECTED_LOGIN_RESPONSE = "OK"

public protocol ElmerAPIClientProtocol {
    func login(email: String) async throws
    func verify(email: String, otp: String) async throws -> ElmerAPIToken
}

public final class ElmerAPIClient: ElmerAPIClientProtocol {
    private let urlSession: URLSession
    private let requestFactory: ElmerAPIRequestFactoryProtocol
    
    public init(
        urlSession: URLSession,
        requestFactory: ElmerAPIRequestFactoryProtocol = ElmerAPIRequestFactory()
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
        
        let (data, _) = try await urlSession.data(
            for: request
        )
        
        return try JSONDecoder().decode(ElmerAPIToken.self, from: data)
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
