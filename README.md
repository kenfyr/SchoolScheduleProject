# SchoolSchedule (SwiftUI + WidgetKit)

Starter Xcode project for an iOS 17+ school timetable app with a home-screen widget.

## Before building
1. Open `SchoolSchedule.xcodeproj` in Xcode (or a cloud Mac).
2. Select both targets and set a unique Bundle Identifier under Signing & Capabilities.
3. Add the **App Groups** capability to both targets and enable the same group in both: `group.com.example.SchoolSchedule`. Replace this example group with one belonging to your developer team in `SharedSchedule.swift` too.
4. Set your Apple Developer Team and enable automatic signing.
5. Build/archive and export the IPA, or push the repo to Codemagic and configure signing.

The app and widget share JSON data using the App Group container. On-device widget refresh timing is managed by iOS, so updates may not appear instantly.
