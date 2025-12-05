import SwiftUI

struct PickerComponentView<T: Hashable>: View {
    let title: String
    let options: [T]
    let label: (T) -> String

    @Binding var selection: T
    @State private var isMenuOpen: Bool = false

    var body: some View {
        Menu {
            Picker("", selection: $selection) {
                ForEach(options, id: \.self) { item in
                    Text(label(item))
                        .tag(item)
                }
            }
        } label: {
            HStack {
                Text(label(selection))
                    .foregroundColor(Color.app(.textPrimary))
                
                Spacer()

                Image(systemName: "chevron.down")
                    .font(.caption)
                    .foregroundColor(Color.app(.textSecondary))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 14)
            .background(Color.app(.componentBackground))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.app(.componentBackgroundBorder), lineWidth: 1)
            )
        }
    }
}

#Preview {
    PickerComponentView(title: "",
                        options: ["A", "B", "C"],
                        label: { $0 },
                        selection: .constant("A"))
}
