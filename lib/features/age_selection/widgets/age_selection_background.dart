import 'package:flutter/material.dart';
import '../age_selection_responsive.dart';
 
// ════════════════════════════════════════════════
// BACKGROUND
// ════════════════════════════════════════════════
class AgeSelectionBackground extends StatelessWidget {
  final AgeSelectionResponsive r;
  const AgeSelectionBackground({super.key, required this.r});
 
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
 
        // Sky gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFF9F0), Color(0xFFFFF0FA)],
            ),
          ),
        ),
 
        // Top left bubble
        Positioned(
          top: -r.bubble1Size * 0.3,
          left: -r.bubble1Size * 0.3,
          child: _Bubble(size: r.bubble1Size, color: const Color(0xFFFFE0D0)),
        ),
 
        // Top right bubble
        Positioned(
          top: r.height * 0.05,
          right: -r.bubble2Size * 0.4,
          child: _Bubble(size: r.bubble2Size, color: const Color(0xFFE0D8FF)),
        ),
 
        // Bottom left bubble
        Positioned(
          bottom: r.height * 0.08,
          left: -r.bubble3Size * 0.3,
          child: _Bubble(size: r.bubble3Size, color: const Color(0xFFD0F5E8)),
        ),
 
        // Bottom grass strip
        Positioned(
          bottom: 0, left: 0, right: 0,
          child: Container(
            height: r.bottomGrassHeight,
            decoration: const BoxDecoration(
              color: Color(0xFF8BC34A),
              borderRadius: BorderRadius.vertical(
                top: Radius.elliptical(300, 60),
              ),
            ),
          ),
        ),
 
        // Grass dots (flowers)
        Positioned(
          bottom: r.bottomGrassHeight * 0.5,
          left: r.width * 0.12,
          child: const Text('🌸', style: TextStyle(fontSize: 20)),
        ),
        Positioned(
          bottom: r.bottomGrassHeight * 0.5,
          left: r.width * 0.40,
          child: const Text('🌼', style: TextStyle(fontSize: 20)),
        ),
        Positioned(
          bottom: r.bottomGrassHeight * 0.5,
          right: r.width * 0.12,
          child: const Text('🌺', style: TextStyle(fontSize: 20)),
        ),
      ],
    );
  }
}
 
// ── Bubble shape ───────────────────────────────
class _Bubble extends StatelessWidget {
  final double size;
  final Color color;
  const _Bubble({required this.size, required this.color});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
