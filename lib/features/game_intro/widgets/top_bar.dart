import 'package:flutter/material.dart';
import 'package:kids_learning/features/game_intro/game_intro_controller.dart';
import 'package:kids_learning/features/game_intro/game_intro_responsive.dart';


class GameIntroTopBar extends StatelessWidget {
  final GameIntroController controller;
  final GameIntroResponsive r;
  final VoidCallback onBack;
  final VoidCallback onSettings;

  const GameIntroTopBar({
    super.key,
    required this.controller,
    required this.r,
    required this.onBack,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    final c = controller.config;
    return Padding(
      padding: EdgeInsets.only(
        top:   r.topBarTopPadding,
        left:  r.topBarPadding,
        right: r.topBarPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          // Back button
          GestureDetector(
            onTap: onBack,
            child: Container(
              width:  r.backBtnSize,
              height: r.backBtnSize,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: r.backIconSize,
              ),
            ),
          ),

          // Age pill
         /* Container(
            padding: EdgeInsets.symmetric(
              vertical:   r.agePillPadV,
              horizontal: r.agePillPadH,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(r.agePillRadius),
            ),
            child: Text(
              c.ageLabel,
              style: TextStyle(
                fontSize:   r.agePillFontSize,
                fontWeight: FontWeight.w800,
                color:      Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),*/

          GestureDetector(
            onTap: onSettings,
            child: Container(
              width:  r.backBtnSize,
              height: r.backBtnSize,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.settings_rounded,
                color: Colors.white,
                size:  r.backIconSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}