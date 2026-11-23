import 'package:flutter/material.dart';

import '../app_theme.dart';
import 'booking_form_page.dart';
import 'data/sample_rooms.dart';
import 'models/room_item.dart';
import 'widgets/room_card.dart';

/// Lab Exercise 6.1 — Page 4: room list, plus the booking form it opens.
///
/// Member 3 deliverable. The login page already navigates here with
/// [routeName]. Choosing a room pushes [BookingFormPage].
class RoomListPage extends StatefulWidget {
  const RoomListPage({super.key});

  static const String routeName = '/rooms';

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  final List<RoomItem> _rooms = createSampleRooms();

  void _openBooking(RoomItem room) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => BookingFormPage(room: room),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.sand,
      body: Column(
        children: <Widget>[
          _header(context),
          Expanded(child: _roomList()),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    final bool canPop = Navigator.of(context).canPop();

    return GradientBackdrop(
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 6, 20, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  if (canPop)
                    IconButton(
                      tooltip: 'Back',
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                    )
                  else
                    const SizedBox(width: 12),
                  Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(38),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white.withAlpha(90)),
                    ),
                    child: const Icon(
                      Icons.hotel_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'HOTEL SUITES',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.4,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Select your room',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: canPop ? 56 : 12),
                child: Text(
                  'Open a suite for details, then reserve your dates.',
                  style: TextStyle(
                    color: Colors.white.withAlpha(210),
                    fontSize: 13.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roomList() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
      children: _rooms.map((RoomItem room) {
        return RoomCard(
          room: room,
          onExpansionChanged: (bool expanded) {
            setState(() => room.isExpanded = expanded);
          },
          onReserve: () => _openBooking(room),
        );
      }).toList(),
    );
  }
}
