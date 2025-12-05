protocol AuthValidatorImp {
    func validatedEmail(_ email: String) -> String
    func validatedPassword(_ password: String) -> String
    func areFieldsNotEmpty(email: String,
                           password: String) -> Bool
}
