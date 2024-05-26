import Combine
import IncidentsDomain

@MainActor
public final class AddIncidentViewModel: ObservableObject {
    
    @Published
    var description: String?
    
    @Published
    var latitude: Double?
    
    @Published
    var longitude: Double?
    
    @Published
    var status: Incident.Status?
    
    @Published
    var typeId: Int?
    
    @Published
    var priority: Int?
    
    @Published
    var issuerId: String?
    
    @Published
    private(set) var isValidInput: Bool = false
    
    private let addIncidentUseCase: AddIncidentUseCase
    private var cancellables: Set<AnyCancellable> = []

    public init(addIncidentUseCase: AddIncidentUseCase) {
        self.addIncidentUseCase = addIncidentUseCase
    }
    
    func onAdd() async {
        
    }
    
    private func observeIputs() {
        
    }
}
