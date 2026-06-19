import 'package:flutter/material.dart';
import 'package:kids_learning/features/game_intro/game_intro_controller.dart';
import 'package:kids_learning/features/game_intro/game_intro_responsive.dart';

class GameIntroBestStars extends StatelessWidget {
  final GameIntroController controller;
  final GameIntroResponsive r;

  const GameIntroBestStars({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (_, _) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '⭐',
            style: TextStyle(fontSize: r.bestStarSize),
          ),
          SizedBox(width: r.bestStarSize * 0.35),
          Text(
            'Best: ${controller.bestStarsLabel}',
            style: TextStyle(
              fontSize:   r.bestFontSize,
              fontWeight: FontWeight.w800,
              color:      Colors.white.withOpacity(0.88),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════
// WAVE DECORATION (bottom)
// ════════════════════════════════════════════════
class GameIntroWave extends StatelessWidget {
  final GameIntroResponsive r;
  const GameIntroWave({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0, left: 0, right: 0,
      child: Container(
        height: r.waveHeight,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.10),
          borderRadius: const BorderRadius.vertical(
            top: Radius.elliptical(300, 60),
          ),
        ),
      ),
    );
  }
}