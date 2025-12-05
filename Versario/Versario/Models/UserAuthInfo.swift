struct UserAuthInfo {
    let email: String
    let password: String
}

extension UserAuthInfo {
    static func fixture(email: String = "",
                        password: String = "") -> UserAuthInfo {
        UserAuthInfo(email: email, password: password)
    }
}
