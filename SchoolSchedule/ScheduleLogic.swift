import Foundation

enum ScheduleLogic {
    static func time(_ string: String, on date: Date) -> Date? {
        let parts = string.split(separator: ":").compactMap { Int($0) }
        guard parts.count == 2 else { return nil }
        return Calendar.current.date(bySettingHour: parts[0], minute: parts[1], second: 0, of: date)
    }

    static func ordered(_ lessons: [Lesson], for date: Date) -> [Lesson] {
        lessons.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
            .sorted { (time($0.startTime, on: date) ?? .distantPast) < (time($1.startTime, on: date) ?? .distantPast) }
    }

    static func widgetLesson(from lessons: [Lesson], now: Date = .now) -> (lesson: Lesson, isNext: Bool)? {
        let today = ordered(lessons, for: now)
        for lesson in today {
            let start = time(lesson.startTime, on: now) ?? .distantPast
            let end = time(lesson.endTime, on: now) ?? .distantPast
            if now >= start && now < end { return (lesson, false) }
            if now < start { return (lesson, true) }
        }
        return nil
    }
}
