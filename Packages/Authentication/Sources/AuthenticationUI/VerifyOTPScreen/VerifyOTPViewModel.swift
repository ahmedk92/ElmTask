import Combine
import AuthenticationDomain
import Dispatch

@MainActor
public final class VerifyOTPViewModel: ObservableObject {
    @Published
    var digit1: String = ""
    @Published
    var digit2: String = ""
    @Published
    var digit3: String = ""
    @Published
    var digit4: String = ""
    
    @Published
    private(set) var cursorIndex: Int = .zero
    
    @Published
    private(set) var didVerificationSucceed: Bool?
    
    @Published
    private(set) var error: Error?
    
    @Published
    private(set) var isLoading: Bool = false
    
    private let email: String
    private var cancellables: Set<AnyCancellable> = []
    private let verifyOTPUseCase: VerifyOTPUseCase
    private let executeAsync: (@escaping () async throws -> Void) -> Void
    
    public init(
        email: String,
        verifyOTPUseCase: VerifyOTPUseCase,
        executeAsync: @escaping (@escaping () async throws -> Void) -> Void
    ) {
        self.email = email
        self.verifyOTPUseCase = verifyOTPUseCase
        self.executeAsync = executeAsync
        observeInput()
    }
    
    public func didConsumeError() {
        error = nil
    }
    
    private func observeInput() {
        Publishers.CombineLatest4(
            $digit1,
            $digit2,
            $digit3,
            $digit4
        )
            .sink { [weak self] digit1, digit2, digit3, digit4 in
                guard let self = self else { return }
                
                if !digit1.isAllNumeric() {
                    self.digit1 = ""
                }
                
                if !digit2.isAllNumeric() {
                    self.digit2 = ""
                }
                
                if !digit3.isAllNumeric() {
                    self.digit3 = ""
                }
                
                if !digit4.isAllNumeric() {
                    self.digit4 = ""
                }
                
                let combined = "\(digit1)\(digit2)\(digit3)\(digit4)"
                
                self.cursorIndex = combined.count
                
                if self.cursorIndex > 3 {
                    verify(otp: combined)
                }
            }
            .store(in: &cancellables)
    }
    
    private func verify(otp: String) {
        executeAsync { [weak self] in
            guard let self = self else { return }
            
            self.isLoading = true
            
            do {
                try await self.verifyOTPUseCase(
                    email: self.email,
                    otp: otp
                )
                
                self.didVerificationSucceed = true
            } catch {
                self.error = error
                self.resetInputs()
            }
            
            self.isLoading = false
        }
    }
    
    private func resetInputs() {
        digit1 = ""
        digit2 = ""
        digit3 = ""
        digit4 = ""
        cursorIndex = .zero
    }
}

private extension String {
    func isAllNumeric() -> Bool {
        allSatisfy(\.isNumber)
    }
}
