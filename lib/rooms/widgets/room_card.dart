import 'package:material_ui/material_ui.dart';

import '../../app_theme.dart';
import '../models/room_item.dart';

/// Expandable suite row on the room list.
class RoomCard extends StatelessWidget {
  const RoomCard({
    super.key,
    required this.room,
    required this.onExpansionChanged,
    required this.onReserve,
  });

  final RoomItem room;
  final ValueChanged<bool> onExpansionChanged;
  final VoidCallback onReserve;

  @override
  Widget build(BuildContext context) {
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
          onExpansionChanged: onExpansionChanged,
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
                    onPressed: onReserve,
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
