# AI Usage Log

**Project:** Hotel Reservation App — TMA3084 Software Engineering Laboratory, Lab Exercise 6

This log records AI assistance used while building the App. Each entry states the prompt given, what the tool proposed, and which suggestions were accepted or rejected, with reasons.

# Amirul (103295)
## Widget Tests & Coverage for `BookingFormPage` (`AC1`–`AC4`) – Gemini

- **AI Tool:** Gemini
- **Prompt Used:**
  > "Debug and complete `test/booking_form_test.dart` for `BookingFormPage` (`lib/rooms/booking_form_page.dart`) across acceptance criteria `AC1`–`AC4`, run `flutter test --coverage`, and log the AI changes and test coverage."

- **Generated Suggestions:**
    - Updated the test import to `package:hotel_reservation_app/rooms/booking_form_page.dart` and `package:hotel_reservation_app/rooms/models/room_item.dart`, passing a `RoomItem` instance into `BookingFormPage(room: sampleRoom)` without `const` on `MaterialApp`.
    - Aligned field/button keys (`guestName`, `guestEmail`, `checkIn`, `checkOut`, `bookNow`), validation assertion (`'Guest name is required'`), and confirmation snackbar text (`'King Room reserved for 2 nights.'`) with `BookingFormPage`.
    - Replaced the simple day-tap date picker helper with `_selectDate` using `initialPickerDate` and `targetDate` to step forward (`'Next month'`) or backward (`'Previous month'`) across months as needed.
    - Updated `AC3` to pick day `10` in a month where day `10` is selectable and reuse that date for check-out so it is not after check-in, and awaited `pumpAndSettle()` after submitting in `AC4` before asserting the `SnackBar`.
    - Summarized line coverage from `coverage/lcov.info` (`95/96` lines / `99.0%` on `lib/rooms/booking_form_page.dart`, and `117/287` lines / `40.8%` overall across instrumented files).

- **Accepted Changes:**
    - Updating `test/booking_form_test.dart` with `RoomItem` setup, matching keys/messages, and the bidirectional `_selectDate` helper so all four tests (`AC1`–`AC4`) pass.
    - Recording the passing test results and updated `lcov.info` coverage metrics in `LOGTEST.md`.

- **Rejected Changes:**
    - Initial `AC3` test date setup that relied on `checkIn.add(const Duration(days: 1))` as the initial picker date without backward month stepping, which failed when rolling over a month boundary.
    - Earlier generic widget/key guesses (`BookingForm` without `room`, `'Name is required'`) before checking `lib/rooms/booking_form_page.dart`.

- **Reasons for Decisions:**
    - `BookingFormPage` requires a non-null `RoomItem` (`room`) and defines specific keys (`guestName`, `guestEmail`, `checkIn`, `checkOut`, `bookNow`) and validation/snackbar strings that must match for `find.byKey` and `find.text` assertions to succeed.
    - Because `showDatePicker` sets `firstDate` to today and defaults check-out's initial date to the day after check-in, explicit month navigation (`Next month` / `Previous month`) prevents unintended month shifts during `AC3` and `AC4`.
    - Running `flutter test --coverage` after fixing `AC3` and `AC4` verified all four acceptance tests pass and increased `BookingFormPage` line coverage from `58.3%` (`56/96`) to `99.0%` (`95/96`).[cite: 2, 3, 4, 5, 6, 7, 8]