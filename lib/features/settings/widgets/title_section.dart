import 'package:flutter/widgets.dart';
import 'package:kids_learning/features/settings/settings_responsive.dart';

class SettingsSectionTitle extends StatelessWidget {
  final String             title;
  final SettingsResponsive r;

  const SettingsSectionTitle({
    super.key,
    required this.title,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: r.sectionPadding),
      child: Text(
        title,
        style: TextStyle(
          fontSize:   r.sectionTitleSize,
          fontWeight: FontWeight.w900,
          color:      const Color(0xFF888888),
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}