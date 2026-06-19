import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/abc_learn/abc_learn_controller.dart';
import 'package:kids_learning/features/games/abc_learn/abc_learn_responsive.dart';

class AbcLetterCard extends StatelessWidget {
  final AbcLearnController controller;
  final AbcLearnResponsive  r;

  const AbcLetterCard({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final letter = controller.currentRound.correct;

    return AnimatedBuilder(
      animation: controller.letterEntranceController,
      builder: (_, child) => Opacity(
        opacity: controller.letterFade.value,
        child:   Transform.scale(
          scale: controller.letterScale.value,
          child: child,
        ),
      ),
      child: Container(
        width:  r.letterCardSize,
        height: r.letterCardSize,
        decoration: BoxDecoration(
          color:        letter.color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(r.letterCardRadius),
          border: Border.all(
            color: letter.color.withOpacity(0.30),
            width: 2.5,
          ),
          boxShadow: [
            BoxShadow(
              color:      letter.color.withOpacity(0.20),
              blurRadius: r.letterShadowBlur,
              offset:     const Offset(0, 6),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          letter.letter,
          style: TextStyle(
            fontSize:   r.letterFontSize,
            fontWeight: FontWeight.w900,
            color:      letter.color,
            height:     1.0,
          ),
        ),
      ),
    );
  }
}