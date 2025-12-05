import Foundation

enum FeelingType: String, CaseIterable, Codable {
    case happy
    case sad
    case anxious
    case inspired
    case calm
    case angry
    case neutral
}

extension FeelingType: CustomStringConvertible {
    var description: String {
        rawValue.capitalized
    }
}

extension FeelingType {
    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .happy:
            "Feliz"
        case .sad:
            "Triste"
        case .anxious:
            "Ansioso"
        case .inspired:
            "Inspirado"
        case .calm:
            "Calmo"
        case .angry:
            "Irritado"
        case .neutral:
            "Neutro"
        }
    }
}
