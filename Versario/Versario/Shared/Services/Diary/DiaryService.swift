import Foundation

final class DiaryService: DiaryServiceImp {
    private let repository = DiaryRepository()

    func fetchDiaries(userID: String) async -> [DiaryEntry] {
        do {
            return try await repository.fetchAllDiaries(for: userID)
        } catch {
            print("Erro ao buscar diários:", error)
            return []
        }
    }

    func saveDiary(_ entry: DiaryEntry) async {
        do {
            try await repository.saveDiary(entry)
        } catch {
            print("Erro ao salvar diário:", error)
        }
    }

    func deleteDiary(_ entryID: UUID) async {
        do {
            try await repository.deleteDiary(entryID)
        } catch {
            print("Erro ao deletar diário:", error)
        }
    }
}
