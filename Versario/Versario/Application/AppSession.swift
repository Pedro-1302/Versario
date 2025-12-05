import Combine
import FirebaseAuth

final class AppSession: ObservableObject {
    @Published private(set) var isUserAuthenticated: Bool = false
    @Published private var userID: String?

    private let storage: KeyValueStorageImp

    init(storage: KeyValueStorageImp = UserDefaultsRepository()) {
        self.storage = storage
        restoreUserSession()
    }

    func getUserID() -> String? {
        userID
    }

    func signIn(userID: String) {
        updateSession(isAuthenticated: true, userID: userID)
    }

    func signOut() {
        updateSession(isAuthenticated: false, userID: nil)
    }
}

// MARK: - Private Extension Views
private extension AppSession {
    func updateSession(isAuthenticated: Bool, userID: String?) {
        isUserAuthenticated = isAuthenticated
        self.userID = userID

        storage.set(isAuthenticated, forKey: AppSessionKeys.isUserAuthenticated)
        storage.set(userID, forKey: AppSessionKeys.userID)
    }

    func restoreUserSession() {
        self.isUserAuthenticated = storage.get(Bool.self,
                                               forKey: AppSessionKeys.isUserAuthenticated) ?? false
        self.userID = storage.get(String.self, forKey: AppSessionKeys.userID)
    }
}
