import Combine
import Combine

final class DiaryEntryFormViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var text: String = ""
    @Published var selectedFeeling: FeelingType = .happy

    private var existingEntry: DiaryEntry?

    init(existingEntry: DiaryEntry? = nil) {
        if let entry = existingEntry {
            self.existingEntry = entry
            self.title = entry.title
            self.text = entry.text
            self.selectedFeeling = entry.feeling
        }
    }

    func isSaveButtonDisabled() -> Bool {
        title.isEmpty || text.isEmpty
    }

    func getDiaryEntry(for userID: String) -> DiaryEntry {
        return if let entry = existingEntry {
            DiaryEntry(id: entry.id,
                       userID: userID,
                       title: title,
                       feeling: selectedFeeling,
                       timestamp: entry.timestamp,
                       text: text)
        } else {
            DiaryEntry(userID: userID,
                       title: title,
                       feeling: selectedFeeling,
                       text: text)
        }
    }

}
