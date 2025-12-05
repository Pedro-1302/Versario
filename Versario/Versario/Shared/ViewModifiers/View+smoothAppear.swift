import SwiftUI

struct FadeSlide: ViewModifier {
    let isVisible: Bool
    var delay: Double = 0

    func body(content: Content) -> some View {
        content
            .opacity(isVisible ? 1 : 0)
            .offset(y: isVisible ? 0 : 20)
            .animation(
                .spring(response: 0.55, dampingFraction: 0.8)
                .delay(delay),
                value: isVisible
            )
    }
}

extension View {
    /// Applies a fade-in and vertical slide animation to the view.
    ///
    /// This modifier animates the view’s opacity from 0 to 1 and moves it vertically
    /// from an offset of 20 points to its original position. Useful for animating
    /// form fields, buttons, or any content that should appear with a smooth entrance.
    ///
    /// - Parameters:
    ///   - isVisible: Boolean flag indicating whether the view should appear.
    ///   - delay: Optional delay in seconds before the animation starts. Defaults to 0.
    ///
    /// - Returns: A view that animates its entrance with a fade and slide effect.
    ///
    /// Example:
    /// ```swift
    /// Text("Email")
    ///     .fadeSlide(isVisible: showFields, delay: 0.1)
    /// ```
    func fadeSlide(isVisible: Bool, delay: Double = 0) -> some View {
        modifier(FadeSlide(isVisible: isVisible, delay: delay))
    }
}
