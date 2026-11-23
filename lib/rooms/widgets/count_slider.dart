import 'package:flutter/material.dart';

import '../../app_theme.dart';

/// Discrete count slider with a value pin above the thumb.
class CountSlider extends StatelessWidget {
  const CountSlider({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.sliderKey,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final Key? sliderKey;

  @override
  Widget build(BuildContext context) {
    final int divisions = (max - min).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label: ${value.round()}',
          style: const TextStyle(color: AppTheme.mutedInk, fontSize: 15),
        ),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            const double side = 24;
            const double pinWidth = 32;
            final double span = (constraints.maxWidth - side * 2).clamp(0, double.infinity);
            final double fraction = ((value - min) / (max - min)).clamp(0.0, 1.0);
            final double thumbX = side + span * fraction;
            final double pinLeft = (thumbX - pinWidth / 2)
                .clamp(0.0, constraints.maxWidth - pinWidth);

            return SizedBox(
              height: 86,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Positioned(
                    left: pinLeft,
                    top: 0,
                    width: pinWidth,
                    child: _ValuePin(text: '${value.round()}'),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: AppTheme.deepTeal,
                        inactiveTrackColor: const Color(0xFFE4E2EE),
                        thumbColor: AppTheme.deepTeal,
                        overlayColor: AppTheme.deepTeal.withAlpha(36),
                        activeTickMarkColor: Colors.white,
                        inactiveTickMarkColor: AppTheme.deepTeal.withAlpha(90),
                        trackHeight: 4,
                        showValueIndicator: ShowValueIndicator.never,
                      ),
                      child: Slider(
                        key: sliderKey,
                        value: value,
                        min: min,
                        max: max,
                        divisions: divisions,
                        onChanged: onChanged,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ValuePin extends StatelessWidget {
  const _ValuePin({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppTheme.deepTeal,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        CustomPaint(
          size: const Size(10, 6),
          painter: _PinTailPainter(color: AppTheme.deepTeal),
        ),
      ],
    );
  }
}

class _PinTailPainter extends CustomPainter {
  const _PinTailPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_PinTailPainter oldDelegate) => oldDelegate.color != color;
}
