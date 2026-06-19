

import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/shared/game_shell_controller.dart';
import 'package:kids_learning/features/games/shared/game_shell_responsive.dart';

class ShellTimerBar extends StatelessWidget {
  final GameShellController controller;
  final GameShellResponsive  r;

  const ShellTimerBar({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final color = controller.config.primaryColor;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.timerBarMarginH),
      child: ListenableBuilder(
        listenable: controller,
        builder: (_, _) {
          final barColor = controller.timerBarColor(color);
          return ClipRRect(
            borderRadius: BorderRadius.circular(r.timerBarRadius),
            child: Container(
              height: r.timerBarHeight,
              color:  barColor.withOpacity(0.18),
              child: FractionallySizedBox(
                alignment:   Alignment.centerLeft,
                widthFactor: controller.timerProgress.clamp(0.0, 1.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color:        barColor,
                    borderRadius: BorderRadius.circular(r.timerBarRadius),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}