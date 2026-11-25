# AI Usage Log

**Project:** Hotel Reservation App — TMA3084 Software Engineering Laboratory, Lab Exercise 6

This log records AI assistance used while building the App. Each entry states the prompt given, what the tool proposed, and which suggestions were accepted or rejected, with reasons.

# Amirul (103295)
## Widget Tests & Coverage for `BookingFormPage` (`AC1`–`AC4`) 

- **AI Tool:** Gemini
- **Prompt Used:**
  > "Debug and complete `test/booking_form_test.dart` for `BookingFormPage` (`lib/rooms/booking_form_page.dart`) across acceptance criteria `AC1`–`AC4`, resolve the `material_ui` localization error in tests, run `flutter test --coverage`, and format the AI log and test log."

- **Generated Suggestions:**
  - Updated `test/booking_form_test.dart` to import `package:material_ui/material_ui.dart` and pass `GlobalMaterialLocalizations.delegates` into `MaterialApp` inside `_buildTestApp()` so `material_ui`'s `TextField` / `TextFormField` widgets find their localization scope during tests.
  - Passed a `RoomItem` instance into `BookingFormPage(room: sampleRoom)` and aligned widget keys (`guestName`, `guestEmail`, `checkIn`, `checkOut`, `bookNow`), validation assertions (`'Guest name is required'`, `'Enter a valid email'`, `'Check-out must be after check-in'`), and snackbar text (`'King Room reserved for 2 nights.'`).
  - Replaced the simple day-tap helper with `_selectDate` using `initialPickerDate` and `targetDate` to step forward (`'Next month'`) or backward (`'Previous month'`) across months as needed.
  - Updated `AC3` to select day `10` in a month where day `10` is valid and reuse that date for check-out, and awaited `pumpAndSettle()` after tapping `'bookNow'` in `AC4` before asserting the `SnackBar`.

- **Accepted Changes:**
  - Using `package:material_ui/material_ui.dart` with `GlobalMaterialLocalizations.delegates` in `_buildTestApp()` so all four widget tests (`AC1`–`AC4`) mount and pass cleanly.
  - Using the bidirectional `_selectDate` helper and matching keys/assertions in `test/booking_form_test.dart`.
  - Recording the passing test run and coverage results in `LOGTEST.md`.

- **Rejected Changes:**
  - Relying solely on `package:flutter/material.dart`'s `MaterialApp` / `Localizations` setup while `BookingFormPage` uses `package:material_ui/material_ui.dart`, which still triggered `No MaterialLocalizations found` from `material_ui`'s internal localization check.
  - Changing `lib/rooms/booking_form_page.dart` away from `package:material_ui/material_ui.dart` when keeping `material_ui` in the test setup solved the localization issue directly.
  - Initial `AC3` date setup without backward month navigation when rolling over a month boundary.

- **Reasons for Decisions:**
  - Because `BookingFormPage` imports `package:material_ui/material_ui.dart`, `material_ui`'s `TextField` checks its own localization context; providing `material_ui`'s `MaterialApp` with `GlobalMaterialLocalizations.delegates` in `_buildTestApp()` resolves the error without altering production widget behavior.
  - Explicit forward/backward month navigation in `_selectDate` keeps `AC3` and `AC4` deterministic across month boundaries.
