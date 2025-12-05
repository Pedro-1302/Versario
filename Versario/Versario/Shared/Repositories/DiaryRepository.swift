import FirebaseFirestore

internal protocol DiaryRepositoryImp {
    func fetchAllDiaries(for userID: String) async throws -> [DiaryEntry]
    func saveDiary(_ entry: DiaryEntry) async throws
    func deleteDiary(_ entryID: UUID) async throws
}

final class DiaryRepository: DiaryRepositoryImp {
    private let db = Firestore.firestore()
    private let collection = "diary_entries"
    
    func fetchAllDiaries(for userID: String) async throws -> [DiaryEntry] {
        let snapshot = try await db.collection(collection)
            .whereField("userID", isEqualTo: userID)
            .getDocuments()
        
        return snapshot.documents.compactMap {
            try? $0.data(as: DiaryEntry.self)
        }
    }
    
    func saveDiary(_ entry: DiaryEntry) async throws {
        try db.collection(collection)
            .document(entry.id.uuidString)
            .setData(from: entry)
    }
    
    func deleteDiary(_ entryID: UUID) async throws {
        try await db.collection(collection)
            .document(entryID.uuidString)
            .delete()
    }
}
