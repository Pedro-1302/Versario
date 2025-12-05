import Foundation

final class UserDefaultsRepository: KeyValueStorageImp {
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func set<T: Codable>(_ value: T, forKey key: String) {
        switch value {
        case let bool as Bool:
            defaults.set(bool, forKey: key)
        case let int as Int:
            defaults.set(int, forKey: key)
        case let string as String:
            defaults.set(string, forKey: key)
        default:
            let data = try? JSONEncoder().encode(value)
            defaults.set(data, forKey: key)
        }
    }

    func get<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
        if T.self == Bool.self {
            return defaults.bool(forKey: key) as? T
        }

        if T.self == Int.self {
            return defaults.integer(forKey: key) as? T
        }

        if T.self == String.self {
            return defaults.string(forKey: key) as? T
        }

        guard let data = defaults.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }

    func remove(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}
