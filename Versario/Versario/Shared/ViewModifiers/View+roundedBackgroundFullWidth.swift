import SwiftUI

struct RoundedBackgroundFullWidth: ViewModifier {
    let backgroundColor: Color
    let width: CGFloat? = nil
    let isCircular: Bool
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .roundedBackground(backgroundColor: backgroundColor,
                               width: width,
                               isCircular: isCircular)
    }
}

extension View {
    /// Applies a rounded background modifier that stretches the view
    /// to use the full available width.
    ///
    /// - Parameters:
    ///   - backgroundColor: The fill color behind the rounded rectangle.
    ///     Defaults to `.clear`, meaning only the border will typically show.
    ///   - isCircular: Whether the background should be pill-shaped.
    ///
    /// - Returns: A view that expands horizontally and displays a rounded background.
    ///
    /// Example:
    /// ```swift
    /// Text("Submit")
    ///     .roundedBackgroundFullWidth(backgroundColor: Color.app(.componentBackground))
    /// ```
    func roundedBackgroundFullWidth(
        backgroundColor: Color = Color.app(.clear),
        isCircular: Bool = false
    ) -> some View {
        modifier(
            RoundedBackgroundFullWidth(
                backgroundColor: backgroundColor,
                isCircular: isCircular
            )
        )
    }
}
