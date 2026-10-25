import WidgetKit
import SwiftUI

struct ScheduleWidget: Widget {
    let kind = "SchoolScheduleWidget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ScheduleWidgetProvider()) { entry in
            ScheduleWidgetView(entry: entry)
        }
        .configurationDisplayName("Расписание")
        .description("Текущий или следующий урок")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct ScheduleWidgetView: View {
    let entry: ScheduleEntry
    var body: some View {
        ZStack {
            Color(red: 0.055, green: 0.065, blue: 0.09)
            VStack(alignment: .leading, spacing: 9) {
                Text(entry.lesson == nil ? "РАСПИСАНИЕ" : (entry.isNext ? "СЛЕДУЮЩИЙ УРОК" : "ТЕКУЩИЙ УРОК"))
                    .font(.system(size: 11, weight: .bold, design: .rounded)).tracking(1.1).foregroundStyle(.white.opacity(0.7))
                if let lesson = entry.lesson {
                    HStack(spacing: 6) {
                        Text(lesson.startTime).font(.system(size: 12, weight: .bold))
                            .padding(.horizontal, 9).padding(.vertical, 5).background(Color.blue, in: Capsule())
                        Text(lesson.endTime).font(.system(size: 12, weight: .medium)).foregroundStyle(.white.opacity(0.7))
                    }
                    Text(lesson.subject).font(.system(size: 23, weight: .bold, design: .rounded)).foregroundStyle(.white).lineLimit(2).minimumScaleFactor(0.7)
                    Spacer(minLength: 0)
                    Text("Кабинет \(lesson.classroom.isEmpty ? "—" : lesson.classroom)").font(.system(size: 11, weight: .semibold)).foregroundStyle(.white.opacity(0.9)).padding(.horizontal, 10).padding(.vertical, 6).background(Color.white.opacity(0.1), in: Capsule())
                } else {
                    Spacer()
                    Text("На сегодня уроков нет").font(.headline).foregroundStyle(.white)
                    Spacer()
                }
            }.padding(16)
        }
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
    }
}
