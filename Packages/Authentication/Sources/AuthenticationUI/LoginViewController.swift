import UIKit
import SwiftUI

public class LoginViewController: UIHostingController<LoginView> {
    private let viewModel: LoginViewModel
    
    public init(
        viewModel: LoginViewModel,
        onLoginSuccess: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        super.init(
            rootView: .init(
                viewModel: viewModel,
                onLoginSuccess: onLoginSuccess
            )
        )
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
