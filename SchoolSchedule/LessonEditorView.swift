import SwiftUI

struct LessonEditorView: View {
    @Environment(\.dismiss) private var dismiss
    let lesson: Lesson?
    let date: Date
    let onSave: (Lesson) -> Void
    @State private var subject = ""
    @State private var classroom = ""
    @State private var startTime = "08:30"
    @State private var endTime = "09:15"
    @State private var lessonDate = Date()
    @State private var note = ""

    init(lesson: Lesson?, date: Date, onSave: @escaping (Lesson) -> Void) {
        self.lesson = lesson; self.date = date; self.onSave = onSave
        _subject = State(initialValue: lesson?.subject ?? "")
        _classroom = State(initialValue: lesson?.classroom ?? "")
        _startTime = State(initialValue: lesson?.startTime ?? "08:30")
        _endTime = State(initialValue: lesson?.endTime ?? "09:15")
        _lessonDate = State(initialValue: lesson?.date ?? date)
        _note = State(initialValue: lesson?.note ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Дата", selection: $lessonDate, displayedComponents: .date)
                TextField("Предмет", text: $subject)
                TextField("Кабинет", text: $classroom)
                TextField("Начало (ЧЧ:ММ)", text: $startTime).keyboardType(.numbersAndPunctuation)
                TextField("Конец (ЧЧ:ММ)", text: $endTime).keyboardType(.numbersAndPunctuation)
                TextField("Заметка", text: $note, axis: .vertical)
            }
            .navigationTitle(lesson == nil ? "Новый урок" : "Изменить урок")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Отмена") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        let value = Lesson(id: lesson?.id ?? UUID(), date: lessonDate, subject: subject.trimmingCharacters(in: .whitespacesAndNewlines), classroom: classroom, startTime: startTime, endTime: endTime, note: note)
                        onSave(value); dismiss()
                    }.disabled(subject.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || !valid(startTime) || !valid(endTime))
                }
            }
        }
    }
    private func valid(_ value: String) -> Bool {
        let p = value.split(separator: ":")
        guard p.count == 2, let h = Int(p[0]), let m = Int(p[1]) else { return false }
        return (0...23).contains(h) && (0...59).contains(m)
    }
}
