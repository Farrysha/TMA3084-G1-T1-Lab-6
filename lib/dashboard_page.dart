import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'room_list_page.dart';

/// Placeholder home after sign-in.
///
/// Visual layout only. The only action is to continue to the room list.
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const String routeName = '/dashboard';

  void _openRooms(BuildContext context) {
    Navigator.of(context).pushNamed(RoomListPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.sand,
      body: Column(
        children: <Widget>[
          _header(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
              children: <Widget>[
                const Text(
                  'Good evening',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.mutedInk,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Your stay, at a glance',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.ink,
                  ),
                ),
                const SizedBox(height: 18),
                _roomsCard(context),
                const SizedBox(height: 14),
                const _PlaceholderTile(
                  icon: Icons.event_available_outlined,
                  title: 'Upcoming reservation',
                  subtitle: 'No booking yet. Choose a suite to get started.',
                ),
                const SizedBox(height: 12),
                const _PlaceholderTile(
                  icon: Icons.person_outline_rounded,
                  title: 'Guest profile',
                  subtitle: 'Account details will appear here after integration.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return GradientBackdrop(
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 6, 12, 22),
          child: Row(
            children: <Widget>[
              IconButton(
                tooltip: 'Sign out',
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ),
              ),
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
                      'Dashboard',
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
        ),
      ),
    );
  }

  Widget _roomsCard(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppTheme.cardRadius),
      elevation: 0,
      child: InkWell(
        key: const Key('dashboardOpenRooms'),
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        onTap: () => _openRooms(context),
        child: Container(
          padding: const EdgeInsets.fromLTRB(18, 18, 16, 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.cardRadius),
            border: Border.all(color: AppTheme.gold.withAlpha(120)),
          ),
          child: Row(
            children: <Widget>[
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: AppTheme.deepTeal,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.king_bed_outlined,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Browse rooms',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.ink,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Open the suite list and pick a room.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.mutedInk,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppTheme.teal),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaceholderTile extends StatelessWidget {
  const _PlaceholderTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radius),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, color: AppTheme.teal),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.ink,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.mutedInk,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
