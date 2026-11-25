import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // ---- Brand palette: "Hotel Suites" -------------------------------
  static const Color deepTeal = Color(0xFF0E4B4F);
  static const Color teal = Color(0xFF14716E);
  static const Color gold = Color(0xFFC8A64B);
  static const Color sand = Color(0xFFF7F3EA);
  static const Color ink = Color(0xFF13201F);
  static const Color mutedInk = Color(0xFF5E6B6A);

  static const double radius = 16.0;
  static const double cardRadius = 26.0;

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[deepTeal, teal],
  );

  static ThemeData get light {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: deepTeal,
      brightness: Brightness.light,
    ).copyWith(primary: deepTeal, secondary: gold, surface: Colors.white);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: sand,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: sand,
        hintStyle: const TextStyle(color: mutedInk, fontSize: 14),
        labelStyle: const TextStyle(color: mutedInk),
        prefixIconColor: teal,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        // Hides the default underline and rounds every field.
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: mutedInk.withAlpha(40)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: teal, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: Color(0xFFB3261E)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: Color(0xFFB3261E), width: 1.6),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: deepTeal,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(54),
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: deepTeal,
          minimumSize: const Size.fromHeight(54),
          side: const BorderSide(color: deepTeal, width: 1.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: teal,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: ink,
        contentTextStyle: TextStyle(color: Colors.white),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class BrandWordmark extends StatelessWidget {
  const BrandWordmark({
    super.key,
    this.tagline = 'Stay well. Stay Hotel.',
    this.compact = false,
  });

  final String tagline;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: compact ? 56 : 68,
          width: compact ? 56 : 68,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(38),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withAlpha(90)),
          ),
          child: const Icon(Icons.hotel_rounded, color: Colors.white, size: 32),
        ),
        const SizedBox(height: 14),
        const Text(
          'HOTEL SUITES',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          tagline,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withAlpha(205),
            fontSize: 13,
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }
}

class GradientBackdrop extends StatelessWidget {
  const GradientBackdrop({super.key, required this.child, this.height});

  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: const BoxDecoration(gradient: AppTheme.brandGradient),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -60,
            right: -40,
            child: _circle(170, Colors.white.withAlpha(25)),
          ),
          Positioned(
            bottom: -50,
            left: -30,
            child: _circle(140, AppTheme.gold.withAlpha(45)),
          ),
          child,
        ],
      ),
    );
  }

  Widget _circle(double size, Color color) => Container(
    height: size,
    width: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}
