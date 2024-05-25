import UIKit
import SwiftUI

public class VerifyOTPViewController: UIHostingController<VerifyOTPView> {
    private let viewModel: VerifyOTPViewModel
    
    public init(
        viewModel: VerifyOTPViewModel,
        onVerificationSuccess: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        super.init(
            rootView: .init(
                viewModel: viewModel,
                onVerificationSuccess: onVerificationSuccess
            )
        )
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
