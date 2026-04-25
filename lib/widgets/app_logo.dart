import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool animate;
  final Duration animationDelay;

  const AppLogo({
    super.key,
    this.size = 120,
    this.animate = true,
    this.animationDelay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    final logoWidget = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(size * 0.22),
          child: Image.asset(
            'assets/logo.jpg',
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: size * 0.18),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Partim',
              style: TextStyle(
                fontSize: size * 0.32,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1E293B),
                letterSpacing: -0.5,
              ),
            ),
            Text(
              'KU',
              style: TextStyle(
                fontSize: size * 0.32,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF4F46E5),
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        SizedBox(height: size * 0.06),
        Text(
          'Kerja Part Time, Gampang!',
          style: TextStyle(
            fontSize: size * 0.11,
            fontWeight: FontWeight.w500,
            color: Colors.grey[500],
            letterSpacing: 0.3,
          ),
        ),
      ],
    );

    if (!animate) return logoWidget;

    return logoWidget
        .animate()
        .fadeIn(delay: animationDelay, duration: 700.ms)
        .scale(
          begin: const Offset(0.85, 0.85),
          end: const Offset(1.0, 1.0),
          delay: animationDelay,
          duration: 700.ms,
          curve: Curves.easeOutBack,
        );
  }
}

class AppLogoSmall extends StatelessWidget {
  final double size;

  const AppLogoSmall({
    super.key,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(size * 0.2),
          child: Image.asset(
            'assets/logo.jpg',
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: size * 0.25),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Partim',
              style: TextStyle(
                fontSize: size * 0.45,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1E293B),
              ),
            ),
            Text(
              'KU',
              style: TextStyle(
                fontSize: size * 0.45,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF4F46E5),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

