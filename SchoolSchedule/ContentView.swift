import SwiftUI

struct ContentView: View {
    @State private var lessons = SharedSchedule.load()
    @State private var selectedDate = Date()
    @State private var editingLesson: Lesson?
    @State private var showingNewLesson = false

    private var todayLessons: [Lesson] { ScheduleLogic.ordered(lessons, for: selectedDate) }

    var body: some View {
        NavigationStack {
            List {
                DatePicker("Дата расписания", selection: $selectedDate, displayedComponents: .date)
                if todayLessons.isEmpty {
                    ContentUnavailableView("Нет уроков", systemImage: "calendar", description: Text("Добавь урок на выбранную дату кнопкой +"))
                }
                ForEach(todayLessons) { lesson in
                    Button { editingLesson = lesson } label: {
                        HStack(spacing: 12) {
                            VStack { Text(lesson.startTime).font(.headline); Text(lesson.endTime).font(.caption).foregroundStyle(.secondary) }
                                .frame(width: 58)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(lesson.subject).font(.headline).foregroundStyle(.primary)
                                Text("Кабинет \(lesson.classroom.isEmpty ? "—" : lesson.classroom)").font(.subheadline).foregroundStyle(.secondary)
                            }
                            Spacer()
                        }.padding(.vertical, 4)
                    }
                    .swipeActions { Button(role: .destructive) { delete(lesson) } label: { Label("Удалить", systemImage: "trash") } }
                }
            }
            .navigationTitle("Расписание")
            .toolbar { ToolbarItem(placement: .topBarTrailing) { Button { showingNewLesson = true } label: { Image(systemName: "plus") } } }
            .sheet(isPresented: $showingNewLesson) { LessonEditorView(lesson: nil, date: selectedDate) { save($0) } }
            .sheet(item: $editingLesson) { lesson in LessonEditorView(lesson: lesson, date: selectedDate) { save($0) } }
        }
    }

    private func save(_ lesson: Lesson) {
        if let index = lessons.firstIndex(where: { $0.id == lesson.id }) { lessons[index] = lesson } else { lessons.append(lesson) }
        SharedSchedule.save(lessons)
    }
    private func delete(_ lesson: Lesson) { lessons.removeAll { $0.id == lesson.id }; SharedSchedule.save(lessons) }
}
