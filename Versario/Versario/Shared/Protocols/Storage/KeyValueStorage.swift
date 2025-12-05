protocol KeyValueStorageImp {
    func set<T: Codable>(_ value: T, forKey key: String)
    func get<T: Codable>(_ type: T.Type, forKey key: String) -> T?
    func remove(forKey key: String)
}
