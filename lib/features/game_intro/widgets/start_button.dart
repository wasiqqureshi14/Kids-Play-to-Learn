import 'package:flutter/material.dart';
import 'package:kids_learning/features/game_intro/game_intro_controller.dart';
import 'package:kids_learning/features/game_intro/game_intro_responsive.dart';

class GameIntroStartButton extends StatelessWidget {
  final GameIntroController controller;
  final GameIntroResponsive r;
  final VoidCallback onTap;

  const GameIntroStartButton({
    super.key,
    required this.controller,
    required this.r,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.startBtnController,
      builder: (_, child) => Opacity(
        opacity: controller.startBtnFade.value,
        child: Transform.scale(
          scale: controller.startBtnScale.value,
          child: child,
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: ListenableBuilder(
          listenable: controller,
          builder: (_, _) => AnimatedScale(
            scale:    controller.isStartPressed ? 0.94 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: Container(
              width:  r.startBtnWidth,
              height: r.startBtnHeight,
              decoration: BoxDecoration(
                color:        Colors.white,
                borderRadius: BorderRadius.circular(r.startBtnRadius),
                boxShadow: [
                  BoxShadow(
                    color:      Colors.black.withOpacity(0.12),
                    blurRadius: 20,
                    offset:     const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_arrow_rounded,
                    color: controller.config.startTextColor,
                    size:  r.startIconSize,
                  ),
                  SizedBox(width: r.startBtnWidth * 0.04),
                  Text(
                    'START',
                    style: TextStyle(
                      fontSize:      r.startBtnFontSize,
                      fontWeight:    FontWeight.w900,
                      color:         controller.config.startTextColor,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}