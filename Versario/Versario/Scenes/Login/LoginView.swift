import SwiftUI
import Combine

struct LoginView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    @EnvironmentObject private var appSession: AppSession
    @State private var showFields = false

    var body: some View {
        VStack {
            NavigationTitleView(title: "Versário")
                .animatedTitle(isVisible: showFields)

            VStack(spacing: 16) {
                TextFieldComponentView(title: "E-mail",
                                       isLoading: loginViewModel.isLoading,
                                       type: .email,
                                       value: $loginViewModel.email)
                .fadeSlide(isVisible: showFields, delay: 0.1)

                TextFieldComponentView(title: "Password",
                                       isLoading: loginViewModel.isLoading,
                                       type: .password,
                                       value: $loginViewModel.password)
                .fadeSlide(isVisible: showFields, delay: 0.2)

                ButtonComponentView(title: "Realizar Login",
                                    isLoading: loginViewModel.isLoading,
                                    action: signIn)
                .fadeSlide(isVisible: showFields, delay: 0.3)
                .padding(.top, 8)

                NavigationLink(destination: SignUpView()) {
                    Text("Criar Conta")
                        .foregroundColor(Color.app(.textPrimary))
                        .outlineRoundedBackground(isCircular: true)
                }
                .disabled(loginViewModel.isLoading)
                .fadeSlide(isVisible: showFields, delay: 0.4)
            }
            .padding(.top, 48)

            Spacer()
        }
        .padding(.horizontal, 24)
        .appBackground()
        .alert(loginViewModel.loginAlertTitle,
               isPresented: $loginViewModel.showLoginAlert) {
            Button("Tentar Novamente", role: .cancel) {
                loginViewModel.showLoginAlert = false
            }
        } message: {
            Text(loginViewModel.loginAlertMessage)
        }
        .onChange(of: loginViewModel.authenticatedUserID) { newUserID in
            guard let newUserID else { return }
            appSession.signIn(userID: newUserID)
        }
        .onAppear(perform: executeAnimation)
    }
}

// MARK: - Private Views
private extension LoginView {
    func signIn() {
        Task { await loginViewModel.signIn() }
    }

    func executeAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            showFields = true
        }
    }
}

#Preview {
    LoginView()
}
