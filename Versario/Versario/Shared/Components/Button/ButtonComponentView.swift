import SwiftUI

struct ButtonComponentView: View {
    let title: String
    let backgroundColor: Color
    let isLoading: Bool
    let action: () -> ()

    init(title: String,
         backgroundColor: Color = Color.app(.accent),
         isLoading: Bool = false,
         action: @escaping () -> Void) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.isLoading = isLoading
        self.action = action
    }

    var body: some View {
        Button {
            if !isLoading { action() }
        } label: {
            ZStack {
                if isLoading {
                    ProgressView()
                        .foregroundColor(Color.app(.textSecondary))
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    Text(title)
                        .foregroundColor(foregroundColor())
                }
            }
            .roundedBackgroundFullWidth(backgroundColor: backgroundColor,
                                        isCircular: true)
        }
        .disabled(isLoading)
    }
}

// MARK: - Private Methods
private extension ButtonComponentView {
    func foregroundColor() -> Color {
        backgroundColor == .app(.accent) ? .app(.buttonTextColor) : .app(.textPrimary)
    }
}

#Preview {
    ButtonComponentView(title: "Button Title") { }
}
