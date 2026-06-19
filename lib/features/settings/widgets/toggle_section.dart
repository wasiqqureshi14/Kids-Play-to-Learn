import 'package:flutter/material.dart';
import 'package:kids_learning/features/settings/settings_responsive.dart';

class SettingsToggleTile extends StatelessWidget {
  final String             title;
  final String             subtitle;
  final String             emoji;
  final Color              color;
  final bool               value;
  final ValueChanged<bool> onChanged;
  final SettingsResponsive r;

  const SettingsToggleTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.color,
    required this.value,
    required this.onChanged,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: r.tileHeight,
      margin: EdgeInsets.symmetric(
        horizontal: r.tileMarginH,
        vertical:   r.tileMarginV,
      ),
      decoration: BoxDecoration(
        color:        Colors.white,
        borderRadius: BorderRadius.circular(r.tileRadius),
        boxShadow: [
          BoxShadow(
            color:      Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset:     const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: r.sectionPadding),
        child: Row(
          children: [

            // Icon box
            Container(
              width:  r.tileIconBoxSize,
              height: r.tileIconBoxSize,
              decoration: BoxDecoration(
                color:        color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(r.tileIconBoxRadius),
              ),
              alignment: Alignment.center,
              child: Text(
                emoji,
                style: TextStyle(fontSize: r.tileIconSize),
              ),
            ),

            SizedBox(width: r.sectionPadding * 0.8),

            // Title + subtitle
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize:   r.tileTitleSize,
                      fontWeight: FontWeight.w800,
                      color:      const Color(0xFF2D2D2D),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: r.tileSubtitleSize,
                      color:    const Color(0xFF888888),
                    ),
                  ),
                ],
              ),
            ),

            // Toggle switch
            Switch(
              value:           value,
              onChanged:       onChanged,
              activeThumbColor:     color,
              activeTrackColor:color.withOpacity(0.30),
            ),
          ],
        ),
      ),
    );
  }
}