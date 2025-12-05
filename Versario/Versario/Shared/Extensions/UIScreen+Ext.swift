import UIKit

extension UIScreen {
    /**
     Returns the current dimensions (width and height) of the device's main screen.
     
     This static method provides a convenient, concise way to retrieve the screen's
     bounds as a single `CGSize` object, which is useful for layout calculations
     and sizing views based on the device's physical screen size.
     
     - Returns: A `CGSize` struct containing the screen's current `width` and `height`
     in points (device coordinates).
     
     - Important: The returned size dynamically reflects the device's current **orientation** (Portrait or Landscape). If the device is rotated, the width and height values will swap.
     
     ### Discussion
     
     Internally, this function accesses the `size` property of the `bounds` of the
     `UIScreen.main` instance.
     
     - SeeAlso:
     - ``UIKit/UIScreen/bounds``
     - `CGSize`
     
     ### Usage Example
     ```swift
     let screenSize = UIScreen.size()
     print("Screen Width: \(screenSize.width)")
     // Output: Screen Width: 393.0 (on iPhone 15 in Portrait)
     
     // To create a View that fills half the screen height:
     Rectangle()
     .frame(height: UIScreen.size().height / 2)
     ```
     */
    static func size() -> CGSize {
        self.main.bounds.size
    }
}
