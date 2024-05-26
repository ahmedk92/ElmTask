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
            .onChange(of: viewModel.didVerificationSucceed, perform: { didVerificationSucceed in
                guard let didVerificationSucceed, didVerificationSucceed else { return }
                onVerificationSuccess()
            })
    }
    
    private var blocks: some View {
        HStack {
            otpBlockView(binding: $viewModel.digit1)
            .focused($cursorIndex, equals: .zero)
            
            otpBlockView(binding: $viewModel.digit2)
            .focused($cursorIndex, equals: 1)
            
            otpBlockView(binding: $viewModel.digit3)
            .focused($cursorIndex, equals: 2)
            
            otpBlockView(binding: $viewModel.digit4)
            .focused($cursorIndex, equals: 3)
        }.padding()
    }
    
    private func otpBlockView(binding: Binding<String>) -> some View {
        TextField(
            "",
            text: binding
        )
        .keyboardType(.numberPad)
        .textFieldStyle(.roundedBorder)
    }
}
