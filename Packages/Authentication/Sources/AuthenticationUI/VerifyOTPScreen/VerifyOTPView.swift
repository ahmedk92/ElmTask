import SwiftUI

public struct VerifyOTPView: View {
    @ObservedObject
    private var viewModel: VerifyOTPViewModel
    
    private let onVerificationSuccess: () -> Void
    
    @FocusState
    private var cursorIndex: Int?
    
    @State
    private var isErrorAlertPresented = false
    
    public init(
        viewModel: VerifyOTPViewModel,
        onVerificationSuccess: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        self.onVerificationSuccess = onVerificationSuccess
    }
    
    public var body: some View {
        VStack {
            Spacer()
            blocks
            Spacer()
        }.navigationTitle("Enter OTP")
            .alert(
                viewModel.error.map(String.init(describing:)) ?? "",
                isPresented: $isErrorAlertPresented,
                actions: {
                    Button("OK", role: .cancel) {
                        viewModel.didConsumeError()
                    }
                }
            )
            .disabled(viewModel.isLoading)
            .onReceive(viewModel.$cursorIndex, perform: { cursorIndex in
                self.cursorIndex = cursorIndex
            })
            .onReceive(viewModel.$didVerificationSucceed, perform: { didVerificationSucceed in
                guard let didVerificationSucceed, didVerificationSucceed else { return }
                onVerificationSuccess()
            })
    }
    
    private var blocks: some View {
        HStack {
            TextField(
                "",
                text: $viewModel.digit1
            )
            .textFieldStyle(.roundedBorder)
            .focused($cursorIndex, equals: .zero)
            
            TextField(
                "",
                text: $viewModel.digit2
            )
            .textFieldStyle(.roundedBorder)
            .focused($cursorIndex, equals: 1)
            
            TextField(
                "",
                text: $viewModel.digit3
            )
            .textFieldStyle(.roundedBorder)
            .focused($cursorIndex, equals: 2)
            
            TextField(
                "",
                text: $viewModel.digit4
            )
            .textFieldStyle(.roundedBorder)
            .focused($cursorIndex, equals: 3)
        }
    }
}
