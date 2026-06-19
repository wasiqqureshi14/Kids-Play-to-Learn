import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/shape_match/shape_match_controller.dart';
import 'package:kids_learning/features/games/shape_match/shape_match_responsive.dart';


class ShapeRoundIndicator extends StatelessWidget {
  final ShapeMatchController controller;
  final ShapeMatchResponsive r;

  const ShapeRoundIndicator({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Round ${controller.currentRoundIndex + 1} of ${controller.totalRounds}',
      style: TextStyle(
        fontSize:   r.roundFontSize,
        fontWeight: FontWeight.w800,
        color:      const Color(0xFF888888),
      ),
    );
  }
}