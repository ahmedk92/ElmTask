import Foundation

public protocol ElmerAPIRequestFactoryProtocol {
    func makeLoginRequest(email: String) throws -> URLRequest
}

public final class ElmerAPIRequestFactory: ElmerAPIRequestFactoryProtocol {
    private let urlComposer: URLComposer = .init()
    private let requestBodyEncoder: RequestBodyEncoder = .init()
    
    public init() {}
    
    public func makeLoginRequest(email: String) throws -> URLRequest {
        guard let url = urlComposer.makeLoginURL(email: email) else { throw Error.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post
        request.httpBody = try requestBodyEncoder.encodeLoginRequestBody(email: email)
        return request
    }
}

private enum HTTPMethod {
    static let get = "GET"
    static let post = "POST"
}

private final class URLComposer {
    func makeLoginURL(email: String) -> URL? {
        var urlComponents: URLComponents = makeBaseURLComponents()
        urlComponents.path = "login"
        return urlComponents.url
    }
    
    func makeBaseURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "ba4caf56-6e45-4662-bbfb-20878b8cd42e.mock.pstmn.io"
        return components
    }
}

extension ElmerAPIRequestFactory {
    public enum Error: Swift.Error {
        case invalidURL
    }
}

private final class RequestBodyEncoder {
    func encodeLoginRequestBody(email: String) throws -> Data {
        struct Body: Encodable {
            let email: String
        }
        
        return try JSONEncoder().encode(Body(email: email))
    }
}
