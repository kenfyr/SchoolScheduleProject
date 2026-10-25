import Foundation

struct Lesson: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var date: Date
    var subject: String
    var classroom: String
    var startTime: String
    var endTime: String
    var note: String = ""
}
