import SwiftUI

public struct AddIncidentView: View {
    private let viewModel: AddIncidentViewModel
    
    public init(viewModel: AddIncidentViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Text("Add incident")
    }
}
