import Foundation

struct AuthValidator: AuthValidatorImp {
    func validatedEmail(_ email: String) -> String {
        email
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
    }

    func validatedPassword(_ password: String) -> String {
        password
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func areFieldsNotEmpty(email: String, password: String) -> Bool {
        !email.isEmpty && !password.isEmpty
    }
}
