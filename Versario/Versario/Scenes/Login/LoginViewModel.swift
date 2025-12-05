import Combine

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isLoading: Bool = false
    @Published var authenticatedUserID: String?
    @Published var didFinishSignIn: Bool = false
    @Published var loginAlertTitle: String = ""
    @Published var loginAlertMessage: String = ""
    @Published var showLoginAlert: Bool = false
    
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
    func signIn() async {
        setLoading(true)
        defer { setLoading(false) }
        
        let validatedEmail = authValidator.validatedEmail(email)
        let validatedPassword = authValidator.validatedEmail(password)
        
        guard authValidator.areFieldsNotEmpty(email: validatedEmail, password: validatedPassword) else {
            loginAlertTitle = "Campos Inválidos"
            loginAlertMessage = "Preencha corretamente e-mail e senha."
            showLoginAlert = true
            return
        }
        
        let authInfo = UserAuthInfo(email: validatedEmail, password: validatedPassword)
        do {
            let uid = try await accountService.signIn(using: authInfo)
            authenticatedUserID = uid
            didFinishSignIn = true
        } catch {
            loginAlertTitle = "Erro no Login"
            loginAlertMessage = "Ocorreu um problema ao realizar o login. Por favor, tente novamente."
            showLoginAlert = true
            print("Error signing in: \(error)")
        }
    }
}

// MARK: Private Methods
private extension LoginViewModel {
    @MainActor
    func setLoading(_ state: Bool) {
        self.isLoading = state
    }
}
