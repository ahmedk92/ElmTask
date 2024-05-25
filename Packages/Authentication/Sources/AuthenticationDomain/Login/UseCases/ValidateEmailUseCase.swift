import Foundation

public final class ValidateEmailUseCase {
    private let emailValidator: EmailValidator
    
    public init(emailValidator: EmailValidator) {
        self.emailValidator = emailValidator
    }
    
    public func callAsFunction(email: String) -> Bool {
        emailValidator.isValidEmail(email: email)
    }
}

extension ValidateEmailUseCase {
    public protocol EmailValidator {
        func isValidEmail(email: String) -> Bool
    }
}
