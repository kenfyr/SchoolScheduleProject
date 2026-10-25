import Foundation
import WidgetKit

enum SharedSchedule {
    static let appGroup = "group.com.example.SchoolSchedule"
    static let storageKey = "lessons.v1"

    static func load() -> [Lesson] {
        guard let defaults = UserDefaults(suiteName: appGroup),
              let data = defaults.data(forKey: storageKey),
              let lessons = try? JSONDecoder().decode([Lesson].self, from: data) else { return [] }
        return lessons
    }

    static func save(_ lessons: [Lesson]) {
        guard let defaults = UserDefaults(suiteName: appGroup),
              let data = try? JSONEncoder().encode(lessons) else { return }
        defaults.set(data, forKey: storageKey)
        WidgetCenter.shared.reloadAllTimelines()
    }
}
