import Foundation

private let EXPECTED_LOGIN_RESPONSE = "OK"

public protocol ElmerAPIClientProtocol {
    func login(email: String) async throws
}

public final class ElmerAPIClient: ElmerAPIClientProtocol {
    private let urlSession: URLSession
    private let elmerAPIRequestFactory: ElmerAPIRequestFactoryProtocol
    
    public init(
        urlSession: URLSession,
        elmerAPIRequestFactory: ElmerAPIRequestFactoryProtocol = ElmerAPIRequestFactory()
    ) {
        self.urlSession = urlSession
        self.elmerAPIRequestFactory = elmerAPIRequestFactory
    }
    
    public func login(email: String) async throws {
        let (data, _) = try await urlSession.data(
            for: elmerAPIRequestFactory.makeLoginRequest(
                email: email
            )
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
}

extension ElmerAPIClient {
    public enum Error: Swift.Error {
        case unexpectedLoginResponseError(
            expectedLoginResponse: String,
            actualLoginResponse: String?
        )
    }
}
