import SwiftUI

struct RoundedBackgroundViewModifier: ViewModifier {
    let backgroundColor: Color
    let width: CGFloat?
    let isCircular: Bool

    private let defaultHeight: CGFloat = 44

    func body(content: Content) -> some View {
        let cornerRadius = isCircular ? defaultHeight / 2 : 10
        content
            .padding(.horizontal, 12)
            .frame(width: width, height: defaultHeight)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(Color.app(.componentBackgroundBorder), lineWidth: 1)
                    )
            )
            .contentShape(Rectangle())
    }
}

extension View {
    /// Applies a rounded background style to the view.
    ///
    /// - Parameters:
    ///   - backgroundColor: The fill color behind the rounded rectangle.
    ///     Defaults to the app’s component background color.
    ///   - width: An optional fixed width. If `nil`, the view sizes itself naturally.
    ///   - isCircular: If `true`, the background becomes pill-shaped.
    ///
    /// - Returns: A view styled with a rounded background.
    ///
    /// Example:
    /// ```swift
    /// Text("Submit")
    ///     .roundedBackground(isCircular: true)
    /// ```
    func roundedBackground(
        backgroundColor: Color = Color.app(.componentBackground),
        width: CGFloat? = nil,
        isCircular: Bool = false
    ) -> some View {
        modifier(
            RoundedBackgroundViewModifier(
                backgroundColor: backgroundColor,
                width: width,
                isCircular: isCircular
            )
        )
    }
}
