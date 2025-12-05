import SwiftUI

extension View {
    /**
     Applies a fixed width and height to the View using a single `CGSize` object.

     This modifier offers a concise way to set a specific frame size, ensuring the
     View occupies the precise width and height defined by the `CGSize`. It's a
     syntactic convenience over calling the native `frame(width:height:)` modifier.

     - Parameters:
     - size: The `CGSize` object containing the desired **width** and **height** for the View in points.

     - Returns: A new View instance with the specified width and height constraints applied.

     ### Discussion

     Internally, this function extracts the `width` and `height` properties from the
     passed `CGSize` and forwards them directly to the base `frame(width:height:)`
     modifier provided by the SwiftUI framework. The layout behavior remains identical
     to the standard frame modifier.

     - Note: This modifier sets **fixed** constraints. If you need dynamic sizing
     (e.g., maximum width, minimum height) or specific alignment behavior,
     use the built-in `frame` modifier directly.

     - SeeAlso:
     - ``SwiftUI/View/frame(width:height:alignment:)``
     - `CGSize`

     ### Usage Example
     ```swift
     Text("Sized Content")
     .customFrame(size: CGSize(width: 200, height: 100))
     .background(Color.blue)
     ```
     */
    func customFrame(size: CGSize) -> some View {
        self.frame(width: size.width, height: size.height)
    }

    /**
     Applies a fade and vertical slide animation to a View, typically used for titles
     or header elements when they appear on screen.

     This modifier animates the View's **opacity** from `0` to `1` and moves it
     vertically from an offset of `-20` points to its original position. It uses a
     spring animation for a smooth and natural transition.

     - Parameters:
     - isVisible: A Boolean flag indicating whether the View should be visible.
     When `true`, the View fades in and slides into place. When `false`, it
     fades out and moves upwards.

     - Returns: A new View instance with the fade-and-slide animation applied.

     ### Discussion
     This modifier is ideal for animating titles or headers in forms and modal
     screens. The spring animation has a **response** of `0.6` and a **dampingFraction**
     of `0.8`, giving a subtle bounce effect.

     - Note: The animation triggers automatically when the `isVisible` value changes.

     ### Usage Example
     ```swift
     NavigationTitleView(title: "Criar Conta")
     .animatedTitle(isVisible: showFields)
     ```
     */
    func animatedTitle(isVisible: Bool) -> some View {
        self.opacity(isVisible ? 1 : 0)
            .offset(y: isVisible ? 0 : -20)
            .animation(.spring(response: 0.6, dampingFraction: 0.8),
                       value: isVisible)
    }
}
