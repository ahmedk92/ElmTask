import IncidentsDomain
import Combine

@MainActor
public final class IncidentsViewModel: ObservableObject {
    
    @Published
    private(set) var isLoading: Bool = false
    
    @Published
    private(set) var incidents: [Incident] = []
    
    @Published
    private(set) var error: Error?
    
    private let getIncidentsUseCase: GetIncidentsUseCase
    
    public init(getIncidentsUseCase: GetIncidentsUseCase) {
        self.getIncidentsUseCase = getIncidentsUseCase
    }
    
    public func onAppear() async {
        isLoading = true
        defer {
            isLoading = false
        }
        
        do {
            incidents = try await getIncidentsUseCase()
            dump(incidents)
        } catch {
            self.error = error
        }
    }
}
