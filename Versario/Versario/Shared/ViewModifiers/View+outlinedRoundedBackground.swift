import SwiftUI

struct OutlinedRoundedBackgroundViewModifier: ViewModifier {
    let backgroundColor: Color = Color.app(.clear)
    let isCircular: Bool

    func body(content: Content) -> some View {
        content
            .roundedBackgroundFullWidth(backgroundColor: backgroundColor,
                                        isCircular: isCircular)
    }
}

extension View {
    /// Applies an outlined rounded background style to the view.
    ///
    /// - Parameter isCircular: Determines whether the background should be circular.
    ///   Defaults to `false`, producing a rounded rectangle.
    ///
    /// - Returns: A view styled with the outlined rounded background.
    ///
    /// Example:
    /// ```swift
    /// Image(systemName: "star")
    ///     .outlineRoundedBackground(isCircular: true)
    /// ```
    func outlineRoundedBackground(isCircular: Bool = false) -> some View {
        modifier(OutlinedRoundedBackgroundViewModifier(isCircular: isCircular))
    }
}
