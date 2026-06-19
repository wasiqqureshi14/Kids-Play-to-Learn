import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/abc_learn/abc_learn_controller.dart';
import 'package:kids_learning/features/games/abc_learn/abc_learn_responsive.dart';


class AbcRoundIndicator extends StatelessWidget {
  final AbcLearnController controller;
  final AbcLearnResponsive  r;

  const AbcRoundIndicator({
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