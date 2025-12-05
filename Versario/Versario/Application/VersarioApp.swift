import SwiftUI

@main
struct VersarioApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
