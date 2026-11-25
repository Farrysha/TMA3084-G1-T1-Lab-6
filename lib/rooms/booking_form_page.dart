import 'package:flutter/material.dart';

import '../app_theme.dart';
import 'models/room_item.dart';
import 'utils/stay_dates.dart';

/// Guest details and stay dates for the suite chosen on the room list.
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
    final DateTime today = dateOnly(DateTime.now());
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
      final DateTime date = dateOnly(picked);
      if (isCheckIn) {
        _checkIn = date;
        _checkInController.text = formatStayDate(date);
      } else {
        _checkOut = date;
        _checkOutController.text = formatStayDate(date);
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
                hintText: 'Ayam',
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
                final bool valid = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                    .hasMatch(email);
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

  int? get _nights => stayNights(_checkIn, _checkOut);
}
