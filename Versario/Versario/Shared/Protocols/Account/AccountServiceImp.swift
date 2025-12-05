protocol AccountServiceImp {
    func signUp(using authInfo: UserAuthInfo) async throws
    func signIn(using authInfo: UserAuthInfo) async throws -> String?
}
