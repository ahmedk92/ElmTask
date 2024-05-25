import Authentication
import Combine

@MainActor
public final class RootViewModel: ObservableObject {
    
    @Published
    public private(set) var authenticationState: AuthenticationState?
    
    @Published
    public private(set) var error: Error?
    
    private let getAuthenticationStateUseCase: GetAuthenticationStateUseCase
    
    public init(
        getAuthenticationStateUseCase: GetAuthenticationStateUseCase
    ) {
        self.getAuthenticationStateUseCase = getAuthenticationStateUseCase
    }
    
    func onAppear() async {
        do {
            authenticationState = try await getAuthenticationStateUseCase()
        } catch {
            self.error = error
        }
    }
}
