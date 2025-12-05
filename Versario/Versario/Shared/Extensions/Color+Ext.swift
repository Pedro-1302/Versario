import SwiftUI

extension Color {
    /**
     Initializes a `Color` instance from a hexadecimal string.

     This initializer supports multiple hex formats, including:

     - `RGB` (3 characters) — shorthand notation (e.g., `"F0A"`).
     - `RRGGBB` (6 characters) — standard hex color format (e.g., `"FF8800"`).
     - `AARRGGBB` (8 characters) — includes an alpha component (e.g., `"80FF8800"`).
     The input may optionally begin with a `#` character.

     If the provided string is invalid or does not match any supported format,
     the initializer defaults to returning `Color.clear`.

     - Parameters:
     - hexString: A string representing the color in hexadecimal format. The
     string may include leading `#` symbols or whitespace, which will be
     removed during normalization.

     ### Discussion

     The initializer begins by sanitizing the input string—removing whitespace
     and optional `#` characters—before converting the remaining text into a
     numeric value using a `Scanner`.

     Depending on the number of characters in the cleaned hexadecimal value,
     the initializer extracts red, green, blue, and optionally alpha components
     using bitwise operations. Shorthand 3-character hex values (`RGB`) are
     expanded to their 6-character equivalents by repeating each nibble.

     Internally, the color is constructed using the `.sRGB` color space to ensure
     consistent rendering across different devices and contexts.

     - Note: This initializer uses fixed normalization rules. If you need to
     support other formats, such as `RGBA` (instead of `ARGB`) or hex strings
     including prefixes, consider adding additional parsing logic.

     ### Supported Formats

     | Format     | Example       | Description                         |
     |------------|---------------|-------------------------------------|
     | `RGB`      | `"FA3"`       | Compact shorthand hex               |
     | `RRGGBB`   | `"FF55CC"`    | Standard hex color without alpha    |
     | `AARRGGBB` | `"80FF55CC"`  | Hex color including alpha channel   |

     ### Usage Example
     ```swift
     // Standard format
     let colorOne = Color(hexString: "#3498DB")

     // Shorthand RGB
     let colorTwo = Color(hexString: "ABC")

     // With alpha (AARRGGBB)
     let colorThree = Color(hexString: "803498DB")

     // Invalid hex returns Color.clear
     let fallbackColor = Color(hexString: "INVALID")
     ```
     */
    init(hexString: String) {
        let cleanedHex = hexString
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")

        var redComponent: Double = 0.0
        var greenComponent: Double = 0.0
        var blueComponent: Double = 0.0
        var alphaComponent: Double = 1.0

        let scanner = Scanner(string: cleanedHex)
        var hexNumber: UInt64 = 0
        guard scanner.scanHexInt64(&hexNumber) else {
            self = Color.clear
            return
        }

        switch cleanedHex.count {
        case 3:
            let r = (hexNumber & 0xF00) >> 8
            let g = (hexNumber & 0x0F0) >> 4
            let b = (hexNumber & 0x00F)
            redComponent = Double(r * 17) / 255.0
            greenComponent = Double(g * 17) / 255.0
            blueComponent = Double(b * 17) / 255.0

        case 6:
            let r = (hexNumber & 0xFF0000) >> 16
            let g = (hexNumber & 0x00FF00) >> 8
            let b = (hexNumber & 0x0000FF)
            redComponent = Double(r) / 255.0
            greenComponent = Double(g) / 255.0
            blueComponent = Double(b) / 255.0

        case 8:
            let a = (hexNumber & 0xFF000000) >> 24
            let r = (hexNumber & 0x00FF0000) >> 16
            let g = (hexNumber & 0x0000FF00) >> 8
            let b = (hexNumber & 0x000000FF)
            alphaComponent = Double(a) / 255.0
            redComponent = Double(r) / 255.0
            greenComponent = Double(g) / 255.0
            blueComponent = Double(b) / 255.0

        default:
            self = Color.clear
            return
        }

        self = Color(
            .sRGB,
            red: redComponent,
            green: greenComponent,
            blue: blueComponent,
            opacity: alphaComponent
        )
    }

    /**
     Returns a predefined color from the app's design system.

     This method centralizes all color definitions, making it easier
     to maintain consistency, swap themes, or support dark mode in the future.

     - Parameter color: The `AppColor` case representing the requested color.
     - Returns: A `Color` instance defined in the design system.

     ### Available Colors

     | Token                       | Description                           |
     |-----------------------------|---------------------------------------|
     | `.background`               | Main app background                   |
     | `.componentBackground`      | Background for cards, fields, etc.    |
     | `.componentBackgroundBorder`| Subtle border for UI components       |
     | `.textPrimary`              | Primary text color                    |
     | `.textSecondary`            | Secondary/descriptive text            |
     | `.accent`                   | App's accent / interactive color      |
     | `.buttonTextColor`          | Text for buttons on filled surfaces   |
     | `.divider`                  | Divider lines                         |
     | `.clear`                    | Transparent color                     |
     */
    static func app(_ color: AppColor) -> Color {
        return switch color {
        case .background:
            Color(hexString: "#E7E4DE")

        case .componentBackground:
            Color(hexString: "#F0EFEB")

        case .componentBackgroundBorder:
            Color(hexString: "#373330").opacity(0.7)

        case .textPrimary:
            Color(hexString: "#1F1D19")

        case .textSecondary:
            Color(hexString: "#7F7D79")

        case .accent:
            Color(hexString: "#35312E")

        case .buttonTextColor:
            Color(hexString: "#ABA7A3")

        case .divider:
            Color(hexString: "#EDE8E5")

        case .clear:
            Color.clear
        }
    }
}
