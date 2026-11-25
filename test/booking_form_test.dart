import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_reservation_app/rooms/booking_form_page.dart';
import 'package:hotel_reservation_app/rooms/models/room_item.dart';
import 'package:material_ui/material_ui.dart';

Widget _buildTestApp() {
  final sampleRoom = RoomItem(
    name: 'King Room',
    details: 'Large bed, free breakfast, sea view',
    bedInfo: '1 King Bed',
    price: 'RM 320',
    imageUrl: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c',
  );

  return MaterialApp(
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    home: BookingFormPage(room: sampleRoom),
  );
}

Future<void> _selectDate(
    WidgetTester tester, {
      required Key fieldKey,
      required DateTime initialPickerDate,
      required DateTime targetDate,
    }) async {
  await tester.tap(find.byKey(fieldKey));
  await tester.pumpAndSettle();

  final int monthsToAdvance =
      (targetDate.year - initialPickerDate.year) * 12 +
          (targetDate.month - initialPickerDate.month);

  if (monthsToAdvance > 0) {
    for (int i = 0; i < monthsToAdvance; i++) {
      await tester.tap(find.byTooltip('Next month'));
      await tester.pumpAndSettle();
    }
  } else if (monthsToAdvance < 0) {
    for (int i = 0; i < monthsToAdvance.abs(); i++) {
      await tester.tap(find.byTooltip('Previous month'));
      await tester.pumpAndSettle();
    }
  }

  await tester.tap(find.text(targetDate.day.toString()).first);
  await tester.pumpAndSettle();
  await tester.tap(find.text('OK'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('AC1', (WidgetTester tester) async {
    await tester.pumpWidget(_buildTestApp());

    await tester.enterText(
      find.byKey(const Key('guestEmail')),
      'guest@example.com',
    );
    await tester.tap(find.byKey(const Key('bookNow')));
    await tester.pump();

    expect(find.text('Guest name is required'), findsOneWidget);
  });

  testWidgets('AC2', (WidgetTester tester) async {
    await tester.pumpWidget(_buildTestApp());

    await tester.enterText(find.byKey(const Key('guestName')), 'Aiman');
    await tester.enterText(
      find.byKey(const Key('guestEmail')),
      'invalid-email.com',
    );
    await tester.tap(find.byKey(const Key('bookNow')));
    await tester.pump();

    expect(find.text('Enter a valid email'), findsOneWidget);
  });

  testWidgets('AC3', (WidgetTester tester) async {
    await tester.pumpWidget(_buildTestApp());

    await tester.enterText(find.byKey(const Key('guestName')), 'Aiman');
    await tester.enterText(
      find.byKey(const Key('guestEmail')),
      'aiman@example.com',
    );

    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final int targetMonth = today.day >= 10 ? today.month + 1 : today.month;
    final DateTime baseMonth = DateTime(today.year, targetMonth, 1);
    final DateTime checkIn = DateTime(baseMonth.year, baseMonth.month, 10);

    await _selectDate(
      tester,
      fieldKey: const Key('checkIn'),
      initialPickerDate: today,
      targetDate: checkIn,
    );

    // Same day as check-in -> not after check-in
    await _selectDate(
      tester,
      fieldKey: const Key('checkOut'),
      initialPickerDate: checkIn.add(const Duration(days: 1)),
      targetDate: checkIn,
    );

    await tester.tap(find.byKey(const Key('bookNow')));
    await tester.pump();

    expect(find.text('Check-out must be after check-in'), findsOneWidget);
  });

  testWidgets('AC4', (WidgetTester tester) async {
    await tester.pumpWidget(_buildTestApp());

    await tester.enterText(find.byKey(const Key('guestName')), 'Aiman');
    await tester.enterText(
      find.byKey(const Key('guestEmail')),
      'aiman@example.com',
    );

    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime checkIn = today.add(const Duration(days: 5));
    final DateTime checkOut = checkIn.add(const Duration(days: 2));

    await _selectDate(
      tester,
      fieldKey: const Key('checkIn'),
      initialPickerDate: today,
      targetDate: checkIn,
    );

    await _selectDate(
      tester,
      fieldKey: const Key('checkOut'),
      initialPickerDate: checkIn.add(const Duration(days: 1)),
      targetDate: checkOut,
    );

    await tester.tap(find.byKey(const Key('bookNow')));
    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('King Room reserved for 2 nights.'), findsOneWidget);
  });
}