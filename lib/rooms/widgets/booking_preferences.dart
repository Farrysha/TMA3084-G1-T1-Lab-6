import 'package:flutter/material.dart';

import '../../app_theme.dart';
import 'count_slider.dart';

/// Adults, children, extras, and room view for the booking form.
class BookingPreferences extends StatelessWidget {
  const BookingPreferences({
    super.key,
    required this.adults,
    required this.children,
    required this.breakfast,
    required this.airportPickup,
    required this.spaAccess,
    required this.roomView,
    required this.onAdultsChanged,
    required this.onChildrenChanged,
    required this.onBreakfastChanged,
    required this.onAirportPickupChanged,
    required this.onSpaAccessChanged,
    required this.onRoomViewChanged,
  });

  final double adults;
  final double children;
  final bool breakfast;
  final bool airportPickup;
  final bool spaAccess;
  final String roomView;
  final ValueChanged<double> onAdultsChanged;
  final ValueChanged<double> onChildrenChanged;
  final ValueChanged<bool> onBreakfastChanged;
  final ValueChanged<bool> onAirportPickupChanged;
  final ValueChanged<bool> onSpaAccessChanged;
  final ValueChanged<String> onRoomViewChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CountSlider(
          label: 'Adults',
          sliderKey: const Key('adultsSlider'),
          value: adults,
          min: 1,
          max: 6,
          onChanged: onAdultsChanged,
        ),
        const SizedBox(height: 8),
        CountSlider(
          label: 'Children',
          sliderKey: const Key('childrenSlider'),
          value: children,
          min: 0,
          max: 4,
          onChanged: onChildrenChanged,
        ),
        const SizedBox(height: 18),
        const SectionLabel('Extras'),
        ExtraCheckboxRow(
          label: 'Breakfast',
          value: breakfast,
          onChanged: onBreakfastChanged,
        ),
        ExtraCheckboxRow(
          label: 'Airport Pickup',
          value: airportPickup,
          onChanged: onAirportPickupChanged,
        ),
        ExtraCheckboxRow(
          label: 'Spa Access',
          value: spaAccess,
          onChanged: onSpaAccessChanged,
        ),
        const SizedBox(height: 12),
        const SectionLabel('Room View'),
        RadioGroup<String>(
          groupValue: roomView,
          onChanged: (String? value) {
            if (value != null) {
              onRoomViewChanged(value);
            }
          },
          child: const Column(
            children: <Widget>[
              RoomViewOption(view: 'City View'),
              RoomViewOption(view: 'Sea View'),
            ],
          ),
        ),
      ],
    );
  }
}

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: const TextStyle(
          color: AppTheme.deepTeal,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class ExtraCheckboxRow extends StatelessWidget {
  const ExtraCheckboxRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 15, color: AppTheme.ink),
          ),
        ),
        Checkbox(
          key: Key('extra$label'),
          value: value,
          activeColor: AppTheme.deepTeal,
          side: BorderSide(color: AppTheme.mutedInk.withAlpha(150)),
          onChanged: (bool? checked) => onChanged(checked ?? false),
        ),
      ],
    );
  }
}

class RoomViewOption extends StatelessWidget {
  const RoomViewOption({super.key, required this.view});

  final String view;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => RadioGroup.maybeOf<String>(context)?.onChanged(view),
      child: Row(
        children: <Widget>[
          Radio<String>(
            key: Key('view$view'),
            value: view,
            activeColor: AppTheme.deepTeal,
          ),
          Text(
            view,
            style: const TextStyle(fontSize: 15, color: AppTheme.ink),
          ),
        ],
      ),
    );
  }
}
