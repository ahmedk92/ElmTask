import IncidentsDomain
import Combine
import Foundation

@MainActor
public final class IncidentsViewModel: ObservableObject {
    
    @Published
    private(set) var isLoading: Bool = false
    
    @Published
    private(set) var filteredIncidents: [Incident] = []
    
    @Published
    private(set) var error: Error?
    
    @Published
    var selectedDateFilter: Date = .now.advanced(
        by: -3 * 365 * 24 * 60 * 60
    )
    
    @Published
    var selectedStatusFilter: IncidentsViewModel.StatusFilter = .none
    
    private let getIncidentsUseCase: GetIncidentsUseCase
    
    private var incidents: [Incident] = []
    private var cancellables: Set<AnyCancellable> = []
    
    public init(getIncidentsUseCase: GetIncidentsUseCase) {
        self.getIncidentsUseCase = getIncidentsUseCase
        observeFilters()
    }
    
    func onAppear() async {
        isLoading = true
        defer {
            isLoading = false
        }
        
        do {
            incidents = try await getIncidentsUseCase()
            applyFilters(
                selectedStatus: selectedStatusFilter.correspondingStatus,
                selectedDate: selectedDateFilter
            )
        } catch {
            self.error = error
        }
    }
    
    func didConsumeError() {
        error = nil
    }
    
    private func observeFilters() {
        Publishers
            .CombineLatest($selectedDateFilter, $selectedStatusFilter)
            .sink { [weak self] date, status in
                self?.applyFilters(
                    selectedStatus: status.correspondingStatus,
                    selectedDate: date
                )
            }.store(in: &cancellables)
    }
    
    private func applyFilters(
        selectedStatus: Incident.Status?,
        selectedDate: Date?
    ) {
        self.filteredIncidents = incidents
            .filter { incident in
                var criteria = true
                
                if let selectedStatus {
                    criteria = criteria && incident.status == selectedStatus
                }
                
                if let selectedDate {
                    criteria = criteria && incident
                        .createdAt
                        .isAfter(selectedDate)
                }
                
                return criteria
            }
    }
}

extension IncidentsViewModel {
    enum StatusFilter: CaseIterable {
        case none
        case submitted
        case inProgress
        case completed
        case rejected
        
        var correspondingStatus: Incident.Status? {
            switch self {
            case .none:
                return nil
            case .submitted:
                return .submitted
            case .inProgress:
                return .inProgress
            case .completed:
                return .completed
            case .rejected:
                return .rejected
            }
        }
    }
}

private extension Date {
    func isAfter(_ date: Date) -> Bool {
        self > date
    }
}
