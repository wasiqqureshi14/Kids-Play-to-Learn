

import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/shared/game_shell_controller.dart';
import 'package:kids_learning/features/games/shared/game_shell_responsive.dart';

class ShellResultDialog extends StatelessWidget {
  final GameShellController controller;
  final GameShellResponsive  r;
  final VoidCallback onPlayAgain;
  final VoidCallback onHome;

  const ShellResultDialog({
    super.key,
    required this.controller,
    required this.r,
    required this.onPlayAgain,
    required this.onHome,
  });

  @override
  Widget build(BuildContext context) {
    final result = controller.result;
    if (result == null) return const SizedBox.shrink();
    final color  = controller.config.primaryColor;
    final dark   = controller.config.darkColor;

    return AnimatedBuilder(
      animation: controller.dialogController,
      builder: (_, child) => Opacity(
        opacity: controller.dialogFade.value,
        child:   Transform.scale(
          scale: controller.dialogScale.value,
          child: child,
        ),
      ),
      child: Container(
        width:   r.dialogWidth,
        padding: EdgeInsets.all(r.dialogPadding),
        decoration: BoxDecoration(
          color:        Colors.white,
          borderRadius: BorderRadius.circular(r.dialogRadius),
          boxShadow: [
            BoxShadow(
              color:      Colors.black.withOpacity(0.15),
              blurRadius: 30,
              offset:     const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            // New best badge
            if (result.isNewBest)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 5,
                ),
                margin: EdgeInsets.only(bottom: r.dialogGapV * 0.6),
                decoration: BoxDecoration(
                  color:        color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '🎉 New Best!',
                  style: TextStyle(
                    fontSize:   r.dialogSubSize,
                    fontWeight: FontWeight.w800,
                    color:      dark,
                  ),
                ),
              ),

            // Title
            Text(
              _resultTitle(result.stars),
              style: TextStyle(
                fontSize:   r.dialogTitleSize,
                fontWeight: FontWeight.w900,
                color:      const Color(0xFF2D2D2D),
              ),
            ),

            SizedBox(height: r.dialogGapV),

            // Stars row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) {
                final earned = i < result.stars;
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: r.dialogStarSpacing,
                  ),
                  child: AnimatedScale(
                    scale:    earned ? 1.0 : 0.75,
                    duration: Duration(milliseconds: 300 + i * 100),
                    child: Text(
                      earned ? '⭐' : '☆',
                      style: TextStyle(
                        fontSize: r.dialogStarSize,
                        color: earned
                          ? Colors.amber
                          : Colors.grey.shade300,
                      ),
                    ),
                  ),
                );
              }),
            ),

            SizedBox(height: r.dialogGapV),

            // Score text
            Text(
              'Score: ${result.score} / ${result.maxScore}',
              style: TextStyle(
                fontSize:   r.dialogScoreSize,
                fontWeight: FontWeight.w800,
                color:      dark,
              ),
            ),

            SizedBox(height: r.dialogGapV * 0.5),

            // Percentage
            Text(
              '${(result.percentage * 100).toStringAsFixed(0)}% correct',
              style: TextStyle(
                fontSize:   r.dialogSubSize,
                fontWeight: FontWeight.w600,
                color:      const Color(0xFF888888),
              ),
            ),

            SizedBox(height: r.dialogBtnMarginTop),

            // Play Again button
            _DialogBtn(
              label:   '▶  Play Again',
              bgColor: color,
              fgColor: Colors.white,
              height:  r.dialogBtnHeight,
              radius:  r.dialogBtnRadius,
              fontSize:r.dialogBtnFontSize,
              onTap:   onPlayAgain,
            ),

            SizedBox(height: r.dialogGapV * 0.6),

            // Home button
            _DialogBtn(
              label:   '🏠  Home',
              bgColor: color.withOpacity(0.12),
              fgColor: dark,
              height:  r.dialogBtnHeight,
              radius:  r.dialogBtnRadius,
              fontSize:r.dialogBtnFontSize,
              onTap:   onHome,
            ),
          ],
        ),
      ),
    );
  }

  String _resultTitle(int stars) {
    switch (stars) {
      case 3:  return 'Amazing! 🎉';
      case 2:  return 'Great Job! 👍';
      case 1:  return 'Good Try! 💪';
      default: return 'Try Again! 🔄';
    }
  }
}

class _DialogBtn extends StatelessWidget {
  final String label;
  final Color  bgColor, fgColor;
  final double height, radius, fontSize;
  final VoidCallback onTap;

  const _DialogBtn({
    required this.label,
    required this.bgColor,
    required this.fgColor,
    required this.height,
    required this.radius,
    required this.fontSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width:  double.infinity,
        height: height,
        decoration: BoxDecoration(
          color:        bgColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize:   fontSize,
            fontWeight: FontWeight.w800,
            color:      fgColor,
          ),
        ),
      ),
    );
  }
}

class ShellPauseDialog extends StatelessWidget {
  final GameShellController controller;
  final GameShellResponsive  r;
  final VoidCallback onResume;
  final VoidCallback onHome;

  const ShellPauseDialog({
    super.key,
    required this.controller,
    required this.r,
    required this.onResume,
    required this.onHome,
  });

  @override
  Widget build(BuildContext context) {
    final color = controller.config.primaryColor;
    final dark  = controller.config.darkColor;

    return Container(
      width:   r.dialogWidth,
      padding: EdgeInsets.all(r.dialogPadding),
      decoration: BoxDecoration(
        color:        Colors.white,
        borderRadius: BorderRadius.circular(r.dialogRadius),
        boxShadow: [
          BoxShadow(
            color:      Colors.black.withOpacity(0.15),
            blurRadius: 30,
            offset:     const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('⏸️', style: TextStyle(fontSize: r.pauseIconSize)),
          SizedBox(height: r.dialogGapV * 0.6),
          Text(
            'Game Paused',
            style: TextStyle(
              fontSize:   r.pauseTitleSize,
              fontWeight: FontWeight.w900,
              color:      const Color(0xFF2D2D2D),
            ),
          ),
          SizedBox(height: r.dialogGapV),
          _DialogBtn(
            label:    '▶  Resume',
            bgColor:  color,
            fgColor:  Colors.white,
            height:   r.pauseBtnHeight,
            radius:   r.pauseBtnRadius,
            fontSize: r.pauseBtnFontSize,
            onTap:    onResume,
          ),
          SizedBox(height: r.dialogGapV * 0.6),
          _DialogBtn(
            label:    '🏠  Home',
            bgColor:  color.withOpacity(0.12),
            fgColor:  dark,
            height:   r.pauseBtnHeight,
            radius:   r.pauseBtnRadius,
            fontSize: r.pauseBtnFontSize,
            onTap:    onHome,
          ),
        ],
      ),
    );
  }
}