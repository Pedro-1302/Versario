import SwiftUI

struct SignUpView: View {
    @StateObject private var signUpViewModel = SignUpViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var showFields = false

    var body: some View {
        VStack {
            NavigationTitleView(title: "Criar Conta")
                .animatedTitle(isVisible: showFields)

            VStack(spacing: 16) {
                TextFieldComponentView(title: "E-mail",
                                       isLoading: signUpViewModel.isLoading,
                                       type: .email,
                                       value: $signUpViewModel.email)
                .fadeSlide(isVisible: showFields, delay: 0.1)

                TextFieldComponentView(title: "Password",
                                       isLoading: signUpViewModel.isLoading,
                                       type: .password,
                                       value: $signUpViewModel.password)
                .fadeSlide(isVisible: showFields, delay: 0.2)

                ButtonComponentView(title: "Criar conta",
                                    isLoading: signUpViewModel.isLoading,
                                    action: signUp)
                .fadeSlide(isVisible: showFields, delay: 0.3)
                .padding(.top, 8)
            }
            .padding(.top, 48)

            Spacer()
        }
        .padding(.horizontal, 24)
        .appBackground()
        .alert("Cadastro Concluído", isPresented: $signUpViewModel.isSignUpping, actions: {
            Button("OK") { dismiss() }
        }, message: {
            Text("Voce criou sua conta, agora sera direcionado para realizar login!")
        })
        .alert(signUpViewModel.signUpAlertTitle, isPresented: $signUpViewModel.showSignUpAlert) {
            Button("Tentar Novamente", role: .cancel) {
                signUpViewModel.showSignUpAlert = false
            }
        } message: {
            Text(signUpViewModel.signUpAlertMessage)
        }
        .onAppear(perform: executeAnimation)
    }
}

// MARK: - Private Views
private extension SignUpView {
    func signUp() {
        Task { await signUpViewModel.signUp() }
    }

    func executeAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            showFields = true
        }
    }
}

#Preview {
    SignUpView()
}
