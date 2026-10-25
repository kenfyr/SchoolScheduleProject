import WidgetKit
import SwiftUI

struct ScheduleEntry: TimelineEntry {
    let date: Date
    let lesson: Lesson?
    let isNext: Bool
}

struct ScheduleWidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> ScheduleEntry { ScheduleEntry(date: .now, lesson: nil, isNext: true) }
    func getSnapshot(in context: Context, completion: @escaping (ScheduleEntry) -> Void) {
        let item = ScheduleLogic.widgetLesson(from: SharedSchedule.load())
        completion(ScheduleEntry(date: .now, lesson: item?.lesson, isNext: item?.isNext ?? true))
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<ScheduleEntry>) -> Void) {
        let item = ScheduleLogic.widgetLesson(from: SharedSchedule.load())
        let entry = ScheduleEntry(date: .now, lesson: item?.lesson, isNext: item?.isNext ?? true)
        completion(Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60))))
    }
}
