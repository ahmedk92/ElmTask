import UIKit
import SwiftUI

public final class IncidentsViewController: UIHostingController<IncidentsView> {
    private let viewModel: IncidentsViewModel
    
    public init(viewModel: IncidentsViewModel) {
        self.viewModel = viewModel
        super.init(rootView: .init(viewModel: viewModel))
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
