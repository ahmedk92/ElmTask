import AuthenticationDomain
import Combine
import Foundation

@MainActor
public final class LoginViewModel: ObservableObject {
    @Published
    private(set) var isValidEmail: Bool = false
    
    @Published
    private(set) var error: Error?
    
    @Published
    var inputEmail: String = ""
    
    @Published
    private(set) var isLoading: Bool = false
    
    private let loginUseCase: LoginUseCase
    private let validateEmailUseCase: ValidateEmailUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    public init(
        loginUseCase: LoginUseCase,
        validateEmailUseCase: ValidateEmailUseCase
    ) {
        self.loginUseCase = loginUseCase
        self.validateEmailUseCase = validateEmailUseCase
        
        observeInputEmail()
    }
    
    public func login() async {
        isLoading = true
        do {
            try await loginUseCase(email: inputEmail)
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    public func didConsumeError() {
        error = nil
    }
    
    private func observeInputEmail() {
        $inputEmail
            .sink { [weak self] email in
                guard let self else { return }
                self.isValidEmail = self.validateEmailUseCase(email: email)
            }.store(in: &cancellables)
    }
}
