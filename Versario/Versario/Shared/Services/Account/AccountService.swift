import FirebaseAuth

final class AccountService: AccountServiceImp {
    private let auth: Auth = .auth()

    func signUp(using authInfo: UserAuthInfo) async throws {
        try await auth.createUser(withEmail: authInfo.email,
                                  password: authInfo.password)
    }
    
    func signIn(using authInfo: UserAuthInfo) async throws -> String? {
        let result = try await auth.signIn(withEmail: authInfo.email,
                                           password: authInfo.password)
        return result.user.uid
    }
}
