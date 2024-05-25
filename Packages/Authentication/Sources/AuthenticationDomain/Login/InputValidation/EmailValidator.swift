import Foundation

// Adapted from: https://www.swiftbysundell.com/articles/validating-email-addresses/
public class EmailValidator: ValidateEmailUseCase.EmailValidator {
    public init() {}
    
    public func isValidEmail(email: String) -> Bool {
        let detector = try? NSDataDetector(
            types: NSTextCheckingResult.CheckingType.link.rawValue
        )
        
        let range = NSRange(
            email.startIndex..<email.endIndex,
            in: email
        )
        
        let matches = detector?.matches(
            in: email,
            options: [],
            range: range
        )
        
        guard let match = matches?.first, matches?.count == 1 else {
            return false
        }
        
        guard match.url?.scheme == "mailto", match.range == range else {
            return false
        }
        
        return true
    }
}
