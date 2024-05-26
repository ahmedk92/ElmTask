import SwiftUI
import IncidentsDomain

public struct IncidentsView: View {
    
    @ObservedObject
    private var viewModel: IncidentsViewModel
    
    let onAddIncident: () -> Void
    
    @State
    private var isErrorAlertPresented: Bool = false
    
    public init(
        viewModel: IncidentsViewModel,
        onAddIncident: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        self.onAddIncident = onAddIncident
    }
    
    public var body: some View {
        VStack {
            filtersView
            incidentsList
        }.navigationTitle("Incidents")
            .toolbar {
                Button("Add") {
                    onAddIncident()
                }
            }
            .alert(
                viewModel.error.map(String.init(describing:)) ?? "",
                isPresented: $isErrorAlertPresented,
                actions: {
                    Button("OK", role: .cancel) {
                        viewModel.didConsumeError()
                    }
                }
            )
            .task {
                await viewModel.onAppear()
            }
    }
    
    private var filtersView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Filters: ")
                Spacer()
                VStack(alignment: .leading) {
                    Text("After: ")
                        .foregroundColor(.black)
                    dateFilterView
                        .labelsHidden()
                }
                statusFilterView
            }
            .padding()
        }
    }
    
    private var dateFilterView: some View {
        DatePicker(
            "",
            selection: $viewModel.selectedDateFilter,
            in: ...Date.now,
            displayedComponents: .date
        )
    }
    
    private var statusFilterView: some View {
        Picker(
            "",
            selection: $viewModel.selectedStatusFilter
        ) {
            ForEach(IncidentsViewModel.StatusFilter.allCases, id: \.self) { statusFilter in
                Text(statusFilter.string)
            }
        }
        .pickerStyle(.menu)
    }
    
    private var incidentsList: some View {
        List {
            ForEach(viewModel.filteredIncidents) { incident in
                IncidentRowView(incident: incident)
            }
        }
    }
}

extension Incident: Identifiable {}

private struct IncidentRowView: View {
    let incident: Incident
    
    var body: some View {
        VStack(alignment: .leading) {
            titleView
                .font(.headline)
            statusView
                .font(.subheadline)
        }
    }
    
    private var titleView: some View {
        Text(incident.description)
            .lineLimit(1)
    }
    
    private var statusView: some View {
        Text(incident.status.string)
    }
}

private extension Incident.Status {
    var string: String {
        switch self {
        case .submitted:
            return "Submitted"
        case .inProgress:
            return "In progress"
        case .completed:
            return "Completed"
        case .rejected:
            return "Rejected"
        }
    }
}

private extension IncidentsViewModel.StatusFilter {
    var string: String {
        switch self {
        case .none:
            return "All"
        case .submitted:
            return "Submitted"
        case .inProgress:
            return "In progress"
        case .completed:
            return "Completed"
        case .rejected:
            return "Rejected"
        }
    }
}
