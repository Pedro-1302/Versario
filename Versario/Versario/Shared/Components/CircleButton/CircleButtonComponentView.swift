import SwiftUI

struct CircleButtonComponentView: View {
    let type: CircleButtonComponentType
    let backgroundColor: Color
    let isLoading: Bool
    let action: () -> ()

    init(type: CircleButtonComponentType,
         backgroundColor: Color = Color.app(.accent),
         isLoading: Bool = false,
         action: @escaping () -> Void) {
        self.type = type
        self.backgroundColor = backgroundColor
        self.isLoading = isLoading
        self.action = action
    }

    var body: some View {
        Button {
            if !isLoading { action() }
        } label: {
            Image(systemName: type.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor(Color.app(.buttonTextColor))
                .padding(12)
                .background(backgroundColor)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
    }
}

#Preview {
    CircleButtonComponentView(type: .add) { }
}
