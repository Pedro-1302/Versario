import SwiftUI

struct NavigationTitleView: View {
    let title: String
    let displayInline: Bool

    init(title: String, displayInline: Bool = false) {
        self.title = title
        self.displayInline = displayInline
    }

    var body: some View {
        Text(title)
            .font(displayInline ? .system(size: 17) : .title.bold())
            .foregroundColor(Color.app(.textPrimary))
            .frame(height: 44)
            .frame(maxWidth: .infinity, alignment: displayInline ? .center : .leading)
    }
}

#Preview {
    NavigationTitleView(title: "Test")
}
