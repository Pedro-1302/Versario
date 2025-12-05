import SwiftUI

struct FormSectionView<Content: View>: View {
    let title: String
    let content: Content

    init(_ title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color.app(.textPrimary))
                .frame(maxWidth: .infinity, alignment: .leading)

            content
        }
    }
}

#Preview {
    FormSectionView("") {
        Text("")
    }
}
