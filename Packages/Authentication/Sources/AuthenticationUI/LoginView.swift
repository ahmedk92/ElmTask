import SwiftUI

public struct LoginView: View {
    
    @ObservedObject
    private var viewModel: LoginViewModel
    
    @State
    private var isErrorAlertPresented = false
    
    let onLoginSuccess: () -> Void
    
    public init(
        viewModel: LoginViewModel,
        onLoginSuccess: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        self.onLoginSuccess = onLoginSuccess
    }
    
    public var body: some View {
        VStack {
            Spacer()
            TextField(
                "Email",
                text: $viewModel.inputEmail
            )
            .textFieldStyle(.roundedBorder)
            .padding()
            .disabled(viewModel.isLoading)
            
            Button(loginButtonTitle) {
                if !viewModel.isLoading {
                    Task {
                        await viewModel.login()
                        onLoginSuccess()
                    }
                }
            }
            .disabled(!viewModel.isValidEmail)
            
            Spacer()
        }
        .padding()
        .alert(
            viewModel.error.map(String.init(describing:)) ?? "",
            isPresented: $isErrorAlertPresented,
            actions: {
                Button("OK", role: .cancel) {
                    viewModel.didConsumeError()
                }
            }
        )
        .onReceive(viewModel.$error, perform: { error in
            isErrorAlertPresented = error.map { _ in true } ?? false
        })
    }
    
    private var loginButtonTitle: String {
        viewModel.isLoading ? "Loading..." : "Login"
    }
}
