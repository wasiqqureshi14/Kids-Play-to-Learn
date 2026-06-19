import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/spell_it/spell_it_controller.dart';
import 'package:kids_learning/features/games/spell_it/spell_it_responsive.dart';

class SpellRoundIndicator extends StatelessWidget {
  final SpellItController controller;
  final SpellItResponsive r;

  const SpellRoundIndicator({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Round ${controller.currentIndex + 1} of ${controller.totalRounds}',
      style: TextStyle(
        fontSize:   r.roundFontSize,
        fontWeight: FontWeight.w800,
        color:      const Color(0xFF888888),
      ),
    );
  }
}