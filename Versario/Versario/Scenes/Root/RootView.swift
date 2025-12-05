import SwiftUI

struct RootView: View {
    @StateObject private var appSession = AppSession()

    var body: some View {
        NavigationView {
            Group {
                if appSession.isUserAuthenticated {
                    DiaryListView()
                } else {
                    LoginView()
                }
            }
        }
        .environmentObject(appSession)
    }
}

#Preview {
    RootView()
}
