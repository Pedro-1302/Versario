import Combine

final class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""

    @Published var isSignUpping: Bool = false
    @Published var isLoading: Bool = false

    @Published var showSignUpAlert: Bool = false
    @Published var signUpAlertTitle: String = ""
    @Published var signUpAlertMessage: String = ""

    private let authValidator: AuthValidatorImp
    private let accountService: AccountServiceImp

    init(
        authValidator: AuthValidatorImp = AuthValidator(),
        accountService: AccountServiceImp = AccountService()
    ) {
        self.authValidator = authValidator
        self.accountService = accountService
    }

    @MainActor
    func signUp() async {
        setLoading(true)
        defer { setLoading(false) }

        let validatedEmail = authValidator.validatedEmail(email)
        let validatedPassword = authValidator.validatedEmail(password)

        guard authValidator.areFieldsNotEmpty(email: validatedEmail, password: validatedPassword) else {
            signUpAlertTitle = "Campos Inválidos"
            signUpAlertMessage = "Preencha corretamente e-mail e senha."
            showSignUpAlert = true
            return
        }

        let authInfo = UserAuthInfo(email: validatedEmail, password: validatedPassword)

        do {
            try await accountService.signUp(using: authInfo)
            isSignUpping = true
        } catch {
            signUpAlertTitle = "Erro ao Criar Conta"
            signUpAlertMessage = "Ocorreu um problema ao criar sua conta. Tente novamente."
            showSignUpAlert = true
            print("Error creating user: \(error)")
        }
    }
}

// MARK: - Private Extensions
private extension SignUpViewModel {
    @MainActor
    func setLoading(_ state: Bool) {
        isLoading = state
    }
}
