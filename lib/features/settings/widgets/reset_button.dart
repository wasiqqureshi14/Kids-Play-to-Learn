import 'package:flutter/material.dart';
import 'package:kids_learning/features/settings/setting_controller.dart';
import 'package:kids_learning/features/settings/settings_responsive.dart';

class SettingsResetButton extends StatelessWidget {
  final SettingsController controller;
  final SettingsResponsive  r;
  final VoidCallback        onTap;

  const SettingsResetButton({
    super.key,
    required this.controller,
    required this.r,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (_, _) => GestureDetector(
        onTap: controller.isResetting ? null : onTap,
        child: Container(
          height: r.resetBtnHeight,
          margin: EdgeInsets.symmetric(horizontal: r.resetBtnMarginH),
          decoration: BoxDecoration(
            color:        const Color(0xFFFF5252).withOpacity(0.10),
            borderRadius: BorderRadius.circular(r.resetBtnRadius),
            border: Border.all(
              color: const Color(0xFFFF5252).withOpacity(0.35),
              width: 2.0,
            ),
          ),
          alignment: Alignment.center,
          child: controller.isResetting
            ? const SizedBox(
                width: 24, height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Color(0xFFFF5252),
                ),
              )
            : Text(
                '🗑️   Reset All Progress',
                style: TextStyle(
                  fontSize:   r.resetBtnFontSize,
                  fontWeight: FontWeight.w800,
                  color:      const Color(0xFFFF5252),
                ),
              ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════
// VERSION TEXT
// ════════════════════════════════════════════════
class SettingsVersion extends StatelessWidget {
  final SettingsResponsive r;
  const SettingsVersion({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return Text(
      'KidSpark v1.0.0',
      style: TextStyle(
        fontSize: r.versionFontSize,
        color:    const Color(0xFFBBBBBB),
      ),
    );
  }
}