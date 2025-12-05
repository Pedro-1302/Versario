import Foundation

protocol DiaryServiceImp {
    func fetchDiaries(userID: String) async -> [DiaryEntry]
    func saveDiary(_ entry: DiaryEntry) async
    func deleteDiary(_ entryID: UUID) async
}
