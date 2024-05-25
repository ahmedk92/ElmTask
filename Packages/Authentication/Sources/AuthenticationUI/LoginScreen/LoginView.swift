import SwiftUI
import Combine

public struct LoginView: View {
    
    @ObservedObject
    private var viewModel: LoginViewModel
    
    @State
    private var isErrorAlertPresented = false
    
    let onLoginSuccess: (String) -> Void
    
    public init(
        viewModel: LoginViewModel,
        onLoginSuccess: @escaping (String) -> Void
    ) {
        self.viewModel = viewModel
        self.onLoginSuccess = onLoginSuccess
    }
    
    public var body: some View {
        VStack {
            Spacer()
            TextField(
                "Email",
                text: $viewModel.email
            )
            .textFieldStyle(.roundedBorder)
            .padding()
            .disabled(viewModel.isLoading)
            
            Button(loginButtonTitle) {
                if !viewModel.isLoading {
                    Task {
                        await viewModel.login()
                    }
                }
            }
            .disabled(!viewModel.isValidEmail)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Enter your email")
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
        .onReceive(viewModel.$didLoginSucceed, perform: { didLoginSucceed in
            guard let didLoginSucceed, didLoginSucceed else { return }
            onLoginSuccess(viewModel.email)
        })
    }
    
    private var loginButtonTitle: String {
        viewModel.isLoading ? "Loading..." : "Login"
    }
}
