import SwiftUI

struct AppBackgroundViewModifier: ViewModifier {
    let backgroundColor: Color

    func body(content: Content) -> some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            content
        }
    }
}

extension View {
    /// Applies an application-wide background color that extends through safe areas.
    ///
    /// - Parameter backgroundColor: The color to use as the background.
    ///   Defaults to your design system's `.background` color.
    ///
    /// - Returns: A view with the background modifier applied.
    ///
    /// Example:
    /// ```swift
    /// MyScreen()
    ///     .appBackground()
    /// ```
    func appBackground(_ backgroundColor: Color = Color.app(.background)) -> some View {
        modifier(AppBackgroundViewModifier(backgroundColor: backgroundColor))
    }
}
