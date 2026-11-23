import 'package:flutter/material.dart';

import 'app_theme.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static const String routeName = '/dashboard';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  static const Color _deep = AppTheme.deepTeal; //headings/sliders/ icons
  static const Color _fieldBg = AppTheme.sand; //date tiles

  //---- State ----
  DateTime? _checkIn;
  DateTime? _checkOut;
  double _adults = 3;
  double _children = 1;
  final Map<String, bool> _extras = {
    'Breakfast': false,
    'Airport Pickup': true,
    'Spa Access': false,
  };
  String _roomView = 'Sea View';
  int _expandedIndex = -1; //which info panel is open (-1 = none)

  static const List<_InfoItem> _infoItems = [
    _InfoItem(
      icon: Icons.pool,
      title: 'Facilities',
      body:
          'Rooftop Infinity Pool, 24-hour gym, Spa & Sauna, Free Wi-Fi and a '
          'Business Lounge.',
    ),
    _InfoItem(
      icon: Icons.restaurant,
      title: 'Dining',
      body: 'Breakfast buffet 6:30 am – 10:30 am. All-day dining Restaurant.',
    ),
    _InfoItem(
      icon: Icons.policy,
      title: 'Hotel Policies',
      body:
          'Check-in from 3:00 pm, check-out by 12:00 noon. Free cancellation '
          'up to 48 hours before arrival.',
    ),
  ];

  //---- Helpers ----
  String _formatDate(DateTime d) {
    const months = [
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
    return '${d.day.toString().padLeft(2, '0')} ${months[d.month - 1]} ${d.year}';
  }

  Future<void> _pickCheckIn() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _checkIn ?? now,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 2),
      helpText: 'Select check-in date',
    );
    if (picked == null) return;
    setState(() {
      _checkIn = picked;
      //check-out must be after check-in
      if (_checkOut != null && !_checkOut!.isAfter(picked)) {
        _checkOut = null;
      }
    });
  }

  Future<void> _pickCheckOut() async {
    if (_checkIn == null) {
      _showMessage('Please select a check-in date first.');
      return;
    }
    final firstDate = _checkIn!.add(const Duration(days: 1));
    final picked = await showDatePicker(
      context: context,
      initialDate: _checkOut ?? firstDate,
      firstDate: firstDate,
      lastDate: DateTime(_checkIn!.year + 2),
      helpText: 'Select check-out date',
    );
    if (picked != null) setState(() => _checkOut = picked);
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  void _goToRooms() {
    if (_checkIn == null || _checkOut == null) {
      _showMessage('Please select your check-in and check-out dates.');
      return;
    }
    Navigator.pushNamed(context, '/rooms');
  }

  // ---- UI ----
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.sand,
      body: Container(
        color: AppTheme.sand,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Shared Hotel Suites header
            GradientBackdrop(
              height: 180,
              child: const SafeArea(
                child: Center(
                  child: BrandWordmark(
                    tagline: 'Welcome back! Find your perfect stay.',
                  ),
                ),
              ),
            ),
            //overlapping white dashboard card
            Transform.translate(
              offset: const Offset(0, -25),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(20),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildReservationCard(),
                    const SizedBox(height: 16),
                    _buildInfoPanels(),
                    const SizedBox(height: 20),
                    _buildRoomsButton(),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReservationCard() {
    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reservation Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _deep,
              ),
            ),
            const SizedBox(height: 14),

            // Date pickers
            _dateTile(
              label: _checkIn == null
                  ? 'Select Check-in Date'
                  : 'Check-in: ${_formatDate(_checkIn!)}',
              onTap: _pickCheckIn,
            ),
            const SizedBox(height: 10),
            _dateTile(
              label: _checkOut == null
                  ? 'Select Check-out Date'
                  : 'Check-out: ${_formatDate(_checkOut!)}',
              onTap: _pickCheckOut,
            ),
            const SizedBox(height: 16),

            //sliders
            _sectionLabel('Adults: ${_adults.round()}'),
            Slider(
              value: _adults,
              min: 1,
              max: 6,
              divisions: 5,
              label: _adults.round().toString(),
              activeColor: _deep,
              onChanged: (v) => setState(() => _adults = v),
            ),
            _sectionLabel('Children: ${_children.round()}'),
            Slider(
              value: _children,
              min: 0,
              max: 4,
              divisions: 4,
              label: _children.round().toString(),
              activeColor: _deep,
              onChanged: (v) => setState(() => _children = v),
            ),
            const SizedBox(height: 8),

            //checkboxes
            _sectionLabel('Extras'),
            ..._extras.keys.map(
              (name) => CheckboxListTile(
                title: Text(name),
                value: _extras[name],
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                activeColor: _deep,
                checkColor: Colors.white,
                onChanged: (v) => setState(() => _extras[name] = v ?? false),
              ),
            ),
            const SizedBox(height: 8),

            //radio buttons
            _sectionLabel('Room View'),
            RadioGroup<String>(
              groupValue: _roomView,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    _roomView = value;
                  });
                }
              },
              child: Column(
                children: [
                  ...['City View', 'Sea View'].map(
                    (view) => RadioListTile<String>(
                      title: Text(view),
                      value: view,
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      activeColor: _deep,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateTile({required String label, required VoidCallback onTap}) {
    return Material(
      color: _fieldBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius),
        side: BorderSide(color: AppTheme.mutedInk.withAlpha(40)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppTheme.radius),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              const Icon(
                Icons.calendar_today_rounded,
                color: AppTheme.teal,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 14, color: AppTheme.ink),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 2),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: _deep,
        ),
      ),
    );
  }

  Widget _buildInfoPanels() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'Hotel Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _deep,
            ),
          ),
        ),
        //only one panel open at a time
        for (int i = 0; i < _infoItems.length; i++)
          Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 8),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.radius),
            ),
            clipBehavior: Clip.antiAlias,
            child: ExpansionTile(
              key: ValueKey('info_${i}_${_expandedIndex == i}'),
              initiallyExpanded: _expandedIndex == i,
              leading: Icon(_infoItems[i].icon, color: _deep),
              title: Text(
                _infoItems[i].title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              shape: const Border(),
              collapsedShape: const Border(),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              onExpansionChanged: (open) {
                setState(() => _expandedIndex = open ? i : -1);
              },
              children: [Text(_infoItems[i].body)],
            ),
          ),
      ],
    );
  }

  Widget _buildRoomsButton() {
    //style (deep teal, 54px high, rounded)
    return ElevatedButton.icon(
      key: const Key('dashboardViewRooms'),
      onPressed: _goToRooms,
      icon: const Icon(Icons.bed),
      label: const Text('View Available Rooms'),
    );
  }
}

class _InfoItem {
  final IconData icon;
  final String title;
  final String body;
  const _InfoItem({
    required this.icon,
    required this.title,
    required this.body,
  });
}
