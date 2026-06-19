import 'package:flutter/material.dart';
import 'package:kids_learning/features/settings/settings_responsive.dart';

class SettingsTopBar extends StatelessWidget {
  final SettingsResponsive r;
  final VoidCallback       onBack;

  const SettingsTopBar({
    super.key,
    required this.r,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: r.topBarHeight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: r.topBarPadding),
        child: Row(
          children: [
            GestureDetector(
              onTap: onBack,
              child: Container(
                width:  r.topBarBtnSize,
                height: r.topBarBtnSize,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF8C69).withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size:  r.topBarIconSize * 0.75,
                  color: const Color(0xFFFF8C69),
                ),
              ),
            ),
            const Spacer(),
            Text(
              '⚙️  Settings',
              style: TextStyle(
                fontSize:   r.topBarTitleSize,
                fontWeight: FontWeight.w900,
                color:      const Color(0xFF2D2D2D),
              ),
            ),
            const Spacer(),
            SizedBox(width: r.topBarBtnSize),
          ],
        ),
      ),
    );
  }
}