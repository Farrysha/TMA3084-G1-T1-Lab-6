import 'package:flutter/material.dart';

import 'app_theme.dart';

/// One bookable suite shown on the room list.
class RoomItem {
  RoomItem({
    required this.name,
    required this.details,
    required this.bedInfo,
    required this.price,
    required this.imageUrl,
    this.isExpanded = false,
  });

  final String name;
  final String details;
  final String bedInfo;
  final String price;
  final String imageUrl;
  bool isExpanded;
}

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
  final List<RoomItem> _rooms = <RoomItem>[
    RoomItem(
      name: 'King Room',
      details:
          'A quiet suite with a large bed, breakfast included, and a sea view.',
      bedInfo: '1 King Bed',
      price: 'RM 320',
      imageUrl:
          'https://images.unsplash.com/photo-1611892440504-42a792e24d32?auto=format&fit=crop&w=600&q=60',
    ),
    RoomItem(
      name: 'Double Bed Room',
      details: 'Two beds, a city view, and a balcony for longer stays.',
      bedInfo: '2 Single Beds',
      price: 'RM 240',
      imageUrl:
          'https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=600&q=60',
    ),
    RoomItem(
      name: 'Family Room',
      details: 'Two bedrooms, a living room, and a small kitchen.',
      bedInfo: '2 Queen Beds + Sofa Bed',
      price: 'RM 480',
      imageUrl:
          'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=600&q=60',
    ),
  ];

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
      children: _rooms.map(_roomCard).toList(),
    );
  }

  Widget _roomCard(RoomItem room) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.ink.withAlpha(22),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        child: ExpansionTile(
          key: ValueKey<String>(room.name),
          initiallyExpanded: room.isExpanded,
          onExpansionChanged: (bool expanded) {
            setState(() => room.isExpanded = expanded);
          },
          tilePadding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
          childrenPadding: EdgeInsets.zero,
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          iconColor: AppTheme.teal,
          collapsedIconColor: AppTheme.mutedInk,
          shape: const RoundedRectangleBorder(side: BorderSide.none),
          collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
          title: Row(
            children: <Widget>[
              _roomImage(room),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      room.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppTheme.ink,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      room.bedInfo,
                      style: const TextStyle(
                        color: AppTheme.teal,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${room.price} / night',
                      style: const TextStyle(
                        color: AppTheme.deepTeal,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          children: <Widget>[
            Container(
              color: AppTheme.sand,
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    room.details,
                    style: const TextStyle(
                      color: AppTheme.ink,
                      fontSize: 13.5,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: <Widget>[
                      Icon(Icons.bed_rounded, size: 18, color: AppTheme.teal),
                      SizedBox(width: 6),
                      Text(
                        'Bed information',
                        style: TextStyle(
                          color: AppTheme.mutedInk,
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    room.bedInfo,
                    style: const TextStyle(
                      color: AppTheme.deepTeal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton(
                    onPressed: () => _openBooking(room),
                    child: const Text('Reserve this room'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _roomImage(RoomItem room) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.network(
        room.imageUrl,
        width: 72,
        height: 72,
        fit: BoxFit.cover,
        errorBuilder: (BuildContext context, Object error, StackTrace? stack) {
          return Container(
            width: 72,
            height: 72,
            color: AppTheme.sand,
            child: const Icon(Icons.hotel_rounded, color: AppTheme.teal),
          );
        },
      ),
    );
  }
}

/// Guest details and stay dates for the suite chosen on [RoomListPage].
class BookingFormPage extends StatefulWidget {
  const BookingFormPage({super.key, required this.room});

  final RoomItem room;

  @override
  State<BookingFormPage> createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _checkInController = TextEditingController();
  final TextEditingController _checkOutController = TextEditingController();

  DateTime? _checkIn;
  DateTime? _checkOut;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _checkInController.dispose();
    _checkOutController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isCheckIn}) async {
    final DateTime today = _dateOnly(DateTime.now());
    final DateTime initial = isCheckIn
        ? (_checkIn ?? today)
        : (_checkOut ?? _checkIn?.add(const Duration(days: 1)) ?? today);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial.isBefore(today) ? today : initial,
      firstDate: today,
      lastDate: today.add(const Duration(days: 365)),
    );
    if (picked == null || !mounted) {
      return;
    }

    setState(() {
      final DateTime date = _dateOnly(picked);
      if (isCheckIn) {
        _checkIn = date;
        _checkInController.text = _formatDate(date);
      } else {
        _checkOut = date;
        _checkOutController.text = _formatDate(date);
      }
    });
  }

  void _submit() {
    final FormState? form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }

    final int nights = _checkOut!.difference(_checkIn!).inDays;
    final String stay = nights == 1 ? '1 night' : '$nights nights';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.room.name} reserved for $stay.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.sand,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _header(context),
              Transform.translate(
                offset: const Offset(0, -28),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _formCard(),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return GradientBackdrop(
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 4,
          left: 8,
          right: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              tooltip: 'Back to rooms',
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Text(
                'RESERVE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.4,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 4, bottom: 36),
              child: Text(
                widget.room.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 26, 22, 26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.ink.withAlpha(22),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Guest details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppTheme.ink,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${widget.room.bedInfo}   ·   ${widget.room.price} / night',
              style: const TextStyle(
                color: AppTheme.deepTeal,
                fontWeight: FontWeight.w700,
                fontSize: 13.5,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Name, email, and stay dates are required.',
              style: TextStyle(color: AppTheme.mutedInk, fontSize: 13.5),
            ),
            const SizedBox(height: 24),
            TextFormField(
              key: const Key('guestName'),
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              cursorColor: AppTheme.teal,
              decoration: const InputDecoration(
                labelText: 'Guest name',
                hintText: 'Nur Farrysha binti Ahmad',
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Guest name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: const Key('guestEmail'),
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autocorrect: false,
              cursorColor: AppTheme.teal,
              decoration: const InputDecoration(
                labelText: 'Email address',
                hintText: 'guest@example.com',
                prefixIcon: Icon(Icons.mail_outline_rounded),
              ),
              validator: (String? value) {
                final String email = value?.trim() ?? '';
                if (email.isEmpty) {
                  return 'Email is required';
                }
                final bool valid = RegExp(
                  r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                ).hasMatch(email);
                if (!valid) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: const Key('checkIn'),
              controller: _checkInController,
              readOnly: true,
              onTap: () => _pickDate(isCheckIn: true),
              cursorColor: AppTheme.teal,
              decoration: const InputDecoration(
                labelText: 'Check-in',
                hintText: 'Select a date',
                prefixIcon: Icon(Icons.calendar_today_outlined),
              ),
              validator: (String? value) {
                if (_checkIn == null) {
                  return 'Check-in date is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: const Key('checkOut'),
              controller: _checkOutController,
              readOnly: true,
              onTap: () => _pickDate(isCheckIn: false),
              cursorColor: AppTheme.teal,
              decoration: const InputDecoration(
                labelText: 'Check-out',
                hintText: 'Select a date',
                prefixIcon: Icon(Icons.calendar_today_outlined),
              ),
              validator: (String? value) {
                if (_checkOut == null) {
                  return 'Check-out date is required';
                }
                if (_checkIn != null && !_checkOut!.isAfter(_checkIn!)) {
                  return 'Check-out must be after check-in';
                }
                return null;
              },
            ),
            if (_nights != null) ...<Widget>[
              const SizedBox(height: 14),
              Text(
                _nights == 1 ? '1 night stay' : '$_nights nights stay',
                style: const TextStyle(
                  color: AppTheme.teal,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            const SizedBox(height: 18),
            ElevatedButton(
              key: const Key('bookNow'),
              onPressed: _submit,
              child: const Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }

  int? get _nights {
    if (_checkIn == null || _checkOut == null || !_checkOut!.isAfter(_checkIn!)) {
      return null;
    }
    return _checkOut!.difference(_checkIn!).inDays;
  }
}

DateTime _dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

String _formatDate(DateTime date) {
  const List<String> months = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${date.day} ${months[date.month - 1]} ${date.year}';
}
