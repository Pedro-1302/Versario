import SwiftUI

struct TextEditorComponentView: View {
    let placeholder: String
    @Binding var text: String
    let minHeight: CGFloat
    
    @FocusState private var isFocused: Bool
    
    init(
        placeholder: String,
        text: Binding<String>,
        minHeight: CGFloat = 150
    ) {
        self.placeholder = placeholder
        self._text = text
        self.minHeight = minHeight
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color.app(.textSecondary))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 14)
            }
            
            TextEditor(text: $text)
                .frame(minHeight: minHeight)
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .foregroundColor(Color.app(.textPrimary))
                .tint(Color.app(.accent))
                .focused($isFocused)
        }
        .background(Color.app(.componentBackground))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isFocused ? Color.app(.accent) :
                            Color.app(.componentBackgroundBorder), lineWidth: 1)
        )
    }
}

#Preview {
    TextEditorComponentView(placeholder: "Type something", text: .constant(""), minHeight: 164)
}
