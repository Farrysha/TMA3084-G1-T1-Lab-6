import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_reservation_app/rooms/rooms.dart';

RoomItem _room() {
  return RoomItem(
    name: 'King Room',
    details: 'A quiet suite.',
    bedInfo: '1 King Bed',
    price: 'RM 320',
    imageUrl: 'https://example.com/room.jpg',
  );
}

Future<void> pumpForm(WidgetTester tester) async {
  // Tall surface so every field and the button are on screen.
  tester.view.physicalSize = const Size(800, 2400);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(MaterialApp(home: BookingFormPage(room: _room())));
}

Future<void> submit(WidgetTester tester) async {
  await tester.ensureVisible(find.byKey(const Key('bookNow')));
  await tester.tap(find.byKey(const Key('bookNow')));
  await tester.pump();
}

Future<void> openPicker(WidgetTester tester, String fieldKey) async {
  await tester.ensureVisible(find.byKey(Key(fieldKey)));
  await tester.tap(find.byKey(Key(fieldKey)));
  await tester.pumpAndSettle();
}

Future<void> confirmPicker(WidgetTester tester) async {
  await tester.tap(find.text('OK'));
  await tester.pumpAndSettle();
}

/// Picks today as check-in and the following day as check-out.
Future<void> pickValidStay(WidgetTester tester) async {
  await openPicker(tester, 'checkIn');
  await confirmPicker(tester); // dialog opens on today
  await openPicker(tester, 'checkOut');
  await confirmPicker(tester); // dialog opens on check-in + 1 day
}

void main() {
  group('Guest name validator', () {
    testWidgets('error when guest name is empty', (WidgetTester tester) async {
      await pumpForm(tester);
      await submit(tester);
      expect(find.text('Guest name is required'), findsOneWidget);
    });

    testWidgets('no error when guest name is filled', (
      WidgetTester tester,
    ) async {
      await pumpForm(tester);
      await tester.enterText(find.byKey(const Key('guestName')), 'Aminah');
      await submit(tester);
      expect(find.text('Guest name is required'), findsNothing);
    });
  });

  group('Email validator', () {
    testWidgets('error when email is empty', (WidgetTester tester) async {
      await pumpForm(tester);
      await submit(tester);
      expect(find.text('Email is required'), findsOneWidget);
    });

    testWidgets('error when email is invalid', (WidgetTester tester) async {
      await pumpForm(tester);
      await tester.enterText(find.byKey(const Key('guestEmail')), 'not-email');
      await submit(tester);
      expect(find.text('Enter a valid email'), findsOneWidget);
    });

    testWidgets('no error when email is valid', (WidgetTester tester) async {
      await pumpForm(tester);
      await tester.enterText(
        find.byKey(const Key('guestEmail')),
        'aminah@example.com',
      );
      await submit(tester);
      expect(find.text('Email is required'), findsNothing);
      expect(find.text('Enter a valid email'), findsNothing);
    });
  });

  group('Check-in validator', () {
    testWidgets('error when check-in is not selected', (
      WidgetTester tester,
    ) async {
      await pumpForm(tester);
      await submit(tester);
      expect(find.text('Check-in date is required'), findsOneWidget);
    });

    testWidgets('no error when check-in is selected', (
      WidgetTester tester,
    ) async {
      await pumpForm(tester);
      await openPicker(tester, 'checkIn');
      await confirmPicker(tester);
      await submit(tester);
      expect(find.text('Check-in date is required'), findsNothing);
    });
  });

  group('Check-out validator', () {
    testWidgets('error when check-out is not selected', (
      WidgetTester tester,
    ) async {
      await pumpForm(tester);
      await submit(tester);
      expect(find.text('Check-out date is required'), findsOneWidget);
    });

    testWidgets('error when check-out is before check-in', (
      WidgetTester tester,
    ) async {
      await pumpForm(tester);

      // Check-in: the 15th of next month.
      await openPicker(tester, 'checkIn');
      await tester.tap(find.byTooltip('Next month'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('15'));
      await confirmPicker(tester);

      // Check-out: today, which is earlier than check-in.
      await openPicker(tester, 'checkOut');
      await tester.tap(find.byTooltip('Previous month'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('${DateTime.now().day}'));
      await confirmPicker(tester);

      await submit(tester);
      expect(find.text('Check-out must be after check-in'), findsOneWidget);
    });

    testWidgets('no error when check-out is after check-in', (
      WidgetTester tester,
    ) async {
      await pumpForm(tester);
      await pickValidStay(tester);
      await submit(tester);
      expect(find.text('Check-out date is required'), findsNothing);
      expect(find.text('Check-out must be after check-in'), findsNothing);
      expect(find.text('1 night stay'), findsOneWidget);
    });
  });

  testWidgets('valid form shows the reservation confirmation', (
    WidgetTester tester,
  ) async {
    await pumpForm(tester);
    await tester.enterText(find.byKey(const Key('guestName')), 'Aminah');
    await tester.enterText(
      find.byKey(const Key('guestEmail')),
      'aminah@example.com',
    );
    await pickValidStay(tester);
    await submit(tester);
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('King Room reserved for 1 night.'), findsOneWidget);
  });
}
