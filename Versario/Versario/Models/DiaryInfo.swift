import Foundation

struct DiaryEntry: Identifiable, Codable {
    let id: UUID
    let userID: String
    let title: String
    let feeling: FeelingType
    let timestamp: Date
    let text: String

    init(id: UUID = UUID(),
         userID: String,
         title: String,
         feeling: FeelingType,
         timestamp: Date = Date(),
         text: String) {
        self.id = id
        self.userID = userID
        self.title = title
        self.feeling = feeling
        self.timestamp = timestamp
        self.text = text
    }
}
