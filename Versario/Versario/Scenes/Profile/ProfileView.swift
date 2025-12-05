import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var appSession: AppSession
    @State private var showFields = false

    var body: some View {
        VStack {
            NavigationTitleView(title: "Perfil")
                .animatedTitle(isVisible: showFields)

            ButtonComponentView(title: "Sair da Conta",
                                action: appSession.signOut)
            .fadeSlide(isVisible: showFields, delay: 0.1)
            .padding(.top, 48)

            Spacer()
        }
        .padding(.horizontal, 24)
        .appBackground()
        .onAppear(perform: executeAnimation)
    }
}

// MARK: - Private Views
private extension ProfileView {
    func executeAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            showFields = true
        }
    }
}

#Preview {
    ProfileView()
}
