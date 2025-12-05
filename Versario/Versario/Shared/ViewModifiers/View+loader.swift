import SwiftUI

struct LoaderModifier: ViewModifier {
    let isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(1.4)
                    .foregroundColor(Color.app(.textSecondary))
            }
        }
        .animation(.easeInOut, value: isLoading)
    }
}

extension View {
    /// Applies a loading overlay on top of the current view.
    ///
    /// - Parameter isLoading: A boolean that determines whether the loading
    ///   indicator is visible. Pass a state or observable property from
    ///   your view model.
    ///
    /// - Returns: A view with the loader applied.
    ///
    /// Example:
    /// ```swift
    /// MyView()
    ///     .loader(viewModel.isFetching)
    /// ```
    func loader(_ isLoading: Bool) -> some View {
        self.modifier(LoaderModifier(isLoading: isLoading))
    }
}
