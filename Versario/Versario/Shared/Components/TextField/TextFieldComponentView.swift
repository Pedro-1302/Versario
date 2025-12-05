import SwiftUI

struct TextFieldComponentView: View {
    let title: String
    let isLoading: Bool

    let type: TextFieldType
    @Binding var value: String
    @State private var isPasswordVisible: Bool = false
    @FocusState private var passwordFocus: SecureFieldFocusType?
    @FocusState private var isCommonFocused: Bool

    init(
        title: String,
        isLoading: Bool = false,
        type: TextFieldType = .common,
        value: Binding<String>
    ) {
        self.title = title
        self.isLoading = isLoading
        self.type = type
        self._value = value
    }

    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                if value.isEmpty {
                    Text(title)
                        .foregroundColor(Color.app(.textSecondary))
                }

                textField()
                    .foregroundColor(Color.app(.textPrimary))
            }

            if type == .password {
                Button {
                    togglePasswordVisibility()
                } label: {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(Color.app(.textSecondary))
                }
                .padding(.trailing, 4)
            }
        }
        .roundedBackground()
        .onTapGesture {
            if type == .password {
                passwordFocus = isPasswordVisible ? .plain : .secure
            } else {
                isCommonFocused = true
            }
        }
        .disabled(isLoading)
    }
}

// MARK: - Private Views
private extension TextFieldComponentView {
    @ViewBuilder
    func textField() -> some View {
        switch type {
        case .common:
            TextField("", text: $value)
                .focused($isCommonFocused)
        case .email:
            TextField("", text: $value)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .focused($isCommonFocused)
        case .password:
            if isPasswordVisible {
                TextField("", text: $value)
                    .focused($passwordFocus, equals: .plain)
            } else {
                SecureField("", text: $value)
                    .focused($passwordFocus, equals: .secure)
            }
        }
    }

    func togglePasswordVisibility() {
        isPasswordVisible.toggle()
        passwordFocus = isPasswordVisible ? .plain : .secure
    }
}

#Preview {
    TextFieldComponentView(title: "TextField Title", value: .constant(""))
}
