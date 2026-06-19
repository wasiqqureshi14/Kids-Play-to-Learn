import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/shared/game_shell_controller.dart';
import 'package:kids_learning/features/games/shared/game_shell_responsive.dart';
import 'package:kids_learning/features/games/shared/widgets/icon_button.dart';

class ShellTopBar extends StatelessWidget {
  final GameShellController controller;
  final GameShellResponsive  r;
  final VoidCallback onPause;
  final VoidCallback onBack;
  final VoidCallback onSettings;

  const ShellTopBar({
    super.key,
    required this.controller,
    required this.r,
    required this.onPause,
    required this.onBack,
    required this.onSettings,   

  });

  @override
  Widget build(BuildContext context) {
    final color = controller.config.primaryColor;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.topBarPadding),
      child: SizedBox(
        height: r.topBarHeight,
        child: Row(
          children: [

            // Back button
            ShellIconBtn(
              icon:    Icons.arrow_back_ios_new_rounded,
              size:    r.topBarBtnSize,
              iconSz:  r.topBarIconSize * 0.75,
              color:   color,
              onTap:   onBack,
            ),

            const Spacer(),

            // Game name
            Text(
              controller.config.gameName,
              style: TextStyle(
                fontSize:   r.topBarTitleSize,
                fontWeight: FontWeight.w900,
                color:      color,
              ),
            ),

            const Spacer(),
             ShellIconBtn(
              icon:   Icons.settings_rounded,
              size:   r.topBarBtnSize,
              iconSz: r.topBarIconSize,
              color:  color,
              onTap:  onSettings,
            ),

            SizedBox(width: r.topBarPadding * 0.4),

            // Pause button
            ShellIconBtn(
              icon:   Icons.pause_rounded,
              size:   r.topBarBtnSize,
              iconSz: r.topBarIconSize,
              color:  color,
              onTap:  onPause,
            ),
          ],
        ),
      ),
    );
  }
}