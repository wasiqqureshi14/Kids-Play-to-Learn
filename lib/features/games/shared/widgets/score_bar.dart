
import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/shared/game_shell_controller.dart';
import 'package:kids_learning/features/games/shared/game_shell_responsive.dart';

class ShellScoreBar extends StatelessWidget {
  final GameShellController controller;
  final GameShellResponsive  r;

  const ShellScoreBar({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final color = controller.config.primaryColor;

    return Container(
      height: r.scoreBarHeight,
      margin: EdgeInsets.symmetric(horizontal: r.scoreBarMargin),
      padding: EdgeInsets.symmetric(
        horizontal: r.scoreBarPadH,
        vertical:   r.scoreBarPadV,
      ),
      decoration: BoxDecoration(
        color:        color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(r.scoreBarRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          // Score section
          ListenableBuilder(
            listenable: controller,
            builder: (_, _) => Row(
              children: [
                Text('🏆', style: TextStyle(fontSize: r.scoreIconSize)),
                SizedBox(width: r.scoreBarPadH * 0.4),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Score',
                      style: TextStyle(
                        fontSize:   r.scoreLabelSize,
                        fontWeight: FontWeight.w700,
                        color:      color.withOpacity(0.70),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: controller.scorePopController,
                      builder: (_, child) => Transform.scale(
                        scale: controller.scorePop.value,
                        child: child,
                      ),
                      child: Text(
                        '${controller.currentScore} / ${controller.maxScore}',
                        style: TextStyle(
                          fontSize:   r.scoreFontSize,
                          fontWeight: FontWeight.w900,
                          color:      color,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Divider
          Container(
            width: 1.5,
            height: r.scoreBarHeight * 0.55,
            color: color.withOpacity(0.20),
          ),

          // Timer section
          ListenableBuilder(
            listenable: controller,
            builder: (_, _) => Row(
              children: [
                Text('⏱️', style: TextStyle(fontSize: r.scoreIconSize)),
                SizedBox(width: r.scoreBarPadH * 0.4),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Time',
                      style: TextStyle(
                        fontSize:   r.scoreLabelSize,
                        fontWeight: FontWeight.w700,
                        color:      controller.timerBarColor(color)
                            .withOpacity(0.70),
                      ),
                    ),
                    Text(
                      controller.timerText,
                      style: TextStyle(
                        fontSize:   r.scoreFontSize,
                        fontWeight: FontWeight.w900,
                        color:      controller.timerBarColor(color),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
