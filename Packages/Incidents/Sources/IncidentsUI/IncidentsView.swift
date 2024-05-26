import SwiftUI
import IncidentsDomain

public struct IncidentsView: View {
    
    @ObservedObject
    private var viewModel: IncidentsViewModel
    
    public init(viewModel: IncidentsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            incidentsList
        }.navigationTitle("Incidents")
            .task {
                await viewModel.onAppear()
            }
    }
    
    private var incidentsList: some View {
        List {
            ForEach(viewModel.incidents) { incident in
                IncidentRowView(incident: incident)
            }
        }
    }
}

extension Incident: Identifiable {}

private struct IncidentRowView: View {
    let incident: Incident
    
    var body: some View {
        VStack {
            titleView
                .font(.headline)
            statusView
                .font(.subheadline)
        }
    }
    
    private var titleView: some View {
        Text(incident.description)
            .lineLimit(1)
            .frame(alignment: .leading)
    }
    
    private var statusView: some View {
        Text(incident.status.string)
            .frame(alignment: .leading)
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
