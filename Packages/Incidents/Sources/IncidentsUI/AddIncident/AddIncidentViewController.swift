import UIKit
import SwiftUI

public class AddIncidentViewController: UIHostingController<AddIncidentView> {
    private let viewModel: AddIncidentViewModel
    
    public init(viewModel: AddIncidentViewModel) {
        self.viewModel = viewModel
        super.init(rootView: .init(viewModel: viewModel))
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
