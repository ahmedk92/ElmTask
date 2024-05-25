import UIKit
import Authentication
import SwiftUI

class RootViewController: UIHostingController<RootView> {
    
    private let viewModel: RootViewModel
    
    init(
        viewModel: RootViewModel,
        onAuthenticationStateChanged: @escaping (AuthenticationState) -> Void
    ) {
        self.viewModel = viewModel
        super.init(
            rootView: .init(
                viewModel: viewModel,
                onAuthenticationStateChanged: onAuthenticationStateChanged
            )
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
