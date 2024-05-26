import Foundation

public protocol ElmerAPIRequestFactoryProtocol {
    func makeLoginRequest(email: String) throws -> URLRequest
    func makeVerifyOTPRequest(
        email: String,
        otp: String
    ) throws -> URLRequest
    func makeGetIncidentsRequest() async throws -> URLRequest
}

public final class ElmerAPIRequestFactory: ElmerAPIRequestFactoryProtocol {
    private let accessTokenAccessor: ElmerAPIAccessTokenAccessor
    private let urlComposer: URLComposer = .init()
    private let requestBodyEncoder: RequestBodyEncoder = .init()
    
    public init(accessTokenAccessor: ElmerAPIAccessTokenAccessor) {
        self.accessTokenAccessor = accessTokenAccessor
    }
    
    public func makeLoginRequest(email: String) throws -> URLRequest {
        guard let url = urlComposer.makeLoginURL() else { throw Error.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post
        request.httpBody = try requestBodyEncoder.encodeLoginRequestBody(email: email)
        return request
    }
    
    public func makeVerifyOTPRequest(
        email: String,
        otp: String
    ) throws -> URLRequest {
        guard let url = urlComposer.makeVerifyOTPURL() else { throw Error.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post
        request.httpBody = try requestBodyEncoder.encodeVerifyOTPRequestBody(
            email: email,
            otp: email
        )
        return request
    }
    
    public func makeGetIncidentsRequest() async throws -> URLRequest {
        guard let url = urlComposer.makeGetIncidentsURL() else { throw Error.invalidURL }
        guard let accessToken = try await accessTokenAccessor.accessToken() else {
            throw Error.missingAccessToken
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get
        request.setValue(
            "Bearer \(accessToken)",
            forHTTPHeaderField: "Authorization"
        )
        return request
    }
}

private enum HTTPMethod {
    static let get = "GET"
    static let post = "POST"
}

private final class URLComposer {
    func makeLoginURL() -> URL? {
        var urlComponents: URLComponents = makeBaseURLComponents()
        urlComponents.path = "/login"
        return urlComponents.url
    }
    
    func makeVerifyOTPURL() -> URL? {
        var urlComponents: URLComponents = makeBaseURLComponents()
        urlComponents.path = "/verify-otp"
        return urlComponents.url
    }
    
    func makeGetIncidentsURL() -> URL? {
        var urlComponents: URLComponents = makeBaseURLComponents()
        urlComponents.path = "/incident"
        return urlComponents.url
    }
    
    private func makeBaseURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "ba4caf56-6e45-4662-bbfb-20878b8cd42e.mock.pstmn.io"
        return components
    }
}

extension ElmerAPIRequestFactory {
    public enum Error: Swift.Error {
        case invalidURL
        case missingAccessToken
    }
}

private final class RequestBodyEncoder {
    func encodeLoginRequestBody(email: String) throws -> Data {
        struct Body: Encodable {
            let email: String
        }
        
        return try JSONEncoder().encode(Body(email: email))
    }
    
    func encodeVerifyOTPRequestBody(
        email: String,
        otp: String
    ) throws -> Data {
        struct Body: Encodable {
            let email: String
            let otp: String
        }
        
        return try JSONEncoder().encode(
            Body(
                email: email,
                otp: otp
            )
        )
    }
}
