import Combine
import SwiftUI

final class DiaryListViewModel: ObservableObject {
    @Published private(set) var diaryEntries: [DiaryEntry] = []
    @Published var isPresentingNewEntryModal: Bool = false
    @Published var entryBeingEdited: DiaryEntry?
    @Published var isLoading: Bool = false

    private let diaryService: DiaryServiceImp

    init(diaryService: DiaryServiceImp = DiaryService()) {
        self.diaryService = diaryService
    }

    @MainActor
    func loadDiaryEntries(for userID: String) async {
        setLoadingState(true)
        defer { setLoadingState(false) }
        let entries = await diaryService.fetchDiaries(userID: userID)
        diaryEntries = entries.sorted { $0.timestamp > $1.timestamp }
    }

    @MainActor
    func saveDiaryEntry(_ entry: DiaryEntry, for userID: String) async {
        await diaryService.saveDiary(entry)
        entryBeingEdited = nil
        isPresentingNewEntryModal = false
        await loadDiaryEntries(for: userID)
    }

    func deleteDiaryEntry(at offsets: IndexSet, for userID: String) async {
        for index in offsets {
            let id = diaryEntries[index].id
            await diaryService.deleteDiary(id)
        }
        await loadDiaryEntries(for: userID)
    }

    func editDiaryEntry(_ diaryEntry: DiaryEntry) {
        entryBeingEdited = diaryEntry
        isPresentingNewEntryModal = true
    }

    func getDiaries() -> [DiaryEntry] {
        diaryEntries
    }
}

// MARK: - Private Methods
private extension DiaryListViewModel {
    @MainActor
    func setLoadingState(_ state: Bool) {
        isLoading = state
    }
}
