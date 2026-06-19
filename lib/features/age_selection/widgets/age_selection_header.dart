import 'package:flutter/material.dart';
import '../age_selection_controller.dart';
import '../age_selection_responsive.dart';
 
// ════════════════════════════════════════════════
// HEADER
// ════════════════════════════════════════════════
class AgeSelectionHeader extends StatelessWidget {
  final AgeSelectionController controller;
  final AgeSelectionResponsive r;
  const AgeSelectionHeader({super.key, required this.controller, required this.r});
 
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.headerController,
      builder: (context, child) => Opacity(
        opacity: controller.headerFade.value,
        child: Transform.translate(
          offset: Offset(0, controller.headerSlide.value),
          child: child,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,   // ← centered
        children: [
          Text('👋', style: TextStyle(fontSize: r.headerEmojiSize)),
          const SizedBox(height: 8),
          Text(
            'Who is Playing?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: r.headerTitleSize,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF2D2D2D),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Pick your game to start the fun!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: r.headerSubtitleSize,
              color: const Color(0xFF888888),
            ),
          ),
        ],
      ),
    );
  }
}