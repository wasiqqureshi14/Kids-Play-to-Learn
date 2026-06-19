import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/shape_match/shape_match_controller.dart';
import 'package:kids_learning/features/games/shape_match/shape_match_responsive.dart';

class ShapeProgressDots extends StatelessWidget {
  final ShapeMatchController controller;
  final ShapeMatchResponsive r;

  const ShapeProgressDots({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(controller.totalRounds, (i) {
        final isDone    = i < controller.currentRoundIndex;
        final isCurrent = i == controller.currentRoundIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width:  r.dotSize * (isCurrent ? 1.6 : 1.0),
          height: r.dotSize,
          margin: EdgeInsets.symmetric(horizontal: r.dotSpacing * 0.5),
          decoration: BoxDecoration(
            color: isDone
              ? const Color(0xFF4ECBA1)
              : isCurrent
                ? const Color(0xFFFF8C69)
                : const Color(0xFFDDDDDD),
            borderRadius: BorderRadius.circular(r.dotSize),
          ),
        );
      }),
    );
  }
}