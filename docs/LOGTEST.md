## Test Run — 25 November 2026
## Test Execution & Coverage: `BookingFormPage` (`AC1`–`AC4`)

## Test Log: `BookingFormPage` (`AC1`–`AC4`)

- **Test File:** `test/booking_form_test.dart`
- **Target Widget:** `BookingFormPage` (`lib/rooms/booking_form_page.dart`)
- **Command:** `flutter test --coverage`
- **Status:** Passed (4/4 acceptance criteria passing, 0 failures)

### Acceptance Criteria Results
- **AC1 (Missing guest name):** Passed — shows `'Guest name is required'`.
- **AC2 (Invalid email format):** Passed — shows `'Enter a valid email'`.
- **AC3 (Check-out not after check-in):** Passed — shows `'Check-out must be after check-in'`.
- **AC4 (Valid booking submission):** Passed — displays `SnackBar` with `'King Room reserved for 2 nights.'`.

### Line Coverage (`coverage/lcov.info`)
- `lib/rooms/booking_form_page.dart`: 95/96 lines (99.0%)
- `lib/rooms/models/room_item.dart`: 1/1 lines (100.0%)
- `lib/rooms/utils/stay_dates.dart`: 6/6 lines (100.0%)
- `lib/app_theme.dart`: 14/55 lines (25.5%)
- `lib/dashboard_page.dart`: 1/129 lines (0.8%)
- **Total:** 117/287 lines (40.8%)