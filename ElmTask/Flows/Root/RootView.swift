import SwiftUI
import Authentication

struct RootView: View {
    
    let onAuthenticationStateChanged: (AuthenticationState) -> Void
    
    public init(
        viewModel: RootViewModel,
        onAuthenticationStateChanged: @escaping (AuthenticationState) -> Void
    ) {
        self.viewModel = viewModel
        self.onAuthenticationStateChanged = onAuthenticationStateChanged
    }
    
    @ObservedObject
    private var viewModel: RootViewModel
    
    var body: some View {
        VStack {
            if let error = viewModel.error {
                Text(error.localizedDescription)
            }
        }.task {
            await viewModel.onAppear()
        }.onChange(
            of: viewModel.authenticationState,
            perform: { authenticationState in
                if let authenticationState {
                    onAuthenticationStateChanged(authenticationState)
                }
            }
        )
    }
}
