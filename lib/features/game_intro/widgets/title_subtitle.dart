import 'package:flutter/material.dart';
import 'package:kids_learning/features/game_intro/game_intro_controller.dart';
import 'package:kids_learning/features/game_intro/game_intro_responsive.dart';

class GameIntroTitle extends StatelessWidget {
  final GameIntroController controller;
  final GameIntroResponsive r;

  const GameIntroTitle({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.titleController,
      builder: (_, child) => Opacity(
        opacity: controller.titleFade.value,
        child: Transform.translate(
          offset: Offset(0, controller.titleSlide.value),
          child: child,
        ),
      ),
      child: Column(
        children: [
          Text(
            controller.config.gameName,
            style: TextStyle(
              fontSize:   r.titleFontSize,
              fontWeight: FontWeight.w900,
              color:      Colors.white,
              letterSpacing: 0.5,
              shadows: const [
                Shadow(
                  color:  Colors.black12,
                  offset: Offset(0, 3),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
          SizedBox(height: r.subtitleTopGap),
          Text(
            controller.config.gameSubtitle,
            style: TextStyle(
              fontSize:   r.subtitleFontSize,
              fontWeight: FontWeight.w700,
              color:      Colors.white.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
  }
}