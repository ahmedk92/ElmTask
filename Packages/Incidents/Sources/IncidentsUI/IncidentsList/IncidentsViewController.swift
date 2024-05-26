import UIKit
import SwiftUI

public final class IncidentsViewController: UIHostingController<IncidentsView> {
    private let viewModel: IncidentsViewModel
    
    public init(
        viewModel: IncidentsViewModel,
        onAddIncident: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        super.init(
            rootView: .init(
                viewModel: viewModel,
                onAddIncident: onAddIncident
            )
        )
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
