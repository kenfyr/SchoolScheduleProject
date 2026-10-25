Codemagic setup

1. Commit this codemagic.yaml at the repository root (same level as SchoolSchedule.xcodeproj folder).
2. In Codemagic, choose the repository and workflow ios-build.
3. Start a build. This workflow is only a compile test and deliberately builds unsigned; it does NOT produce an installable IPA.
4. After the compile test succeeds, configure signing and App Groups before creating a signed IPA for a real iPhone.
