import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/spell_it/spell_it_controller.dart';
import 'package:kids_learning/features/games/spell_it/spell_it_responsive.dart';

class SpellAnswerBox extends StatelessWidget {
  final BoxState   state;
  final String     letter;
  final double     size;
  final double     radius;
  final double     fontSize;
  final double     borderWidth;
  final Color      activeColor;
  final Color      lightColor;

  const SpellAnswerBox({
    super.key,
    required this.state,
    required this.letter,
    required this.size,
    required this.radius,
    required this.fontSize,
    required this.borderWidth,
    required this.activeColor,
    required this.lightColor,
  });

  @override
  Widget build(BuildContext context) {

    Color bgColor;
    Color borderColor;
    Color textColor;

    switch (state) {
      case BoxState.empty:
        bgColor     = lightColor;
        borderColor = activeColor.withOpacity(0.30);
        textColor   = Colors.transparent;
        break;
      case BoxState.filled:
        bgColor     = activeColor;
        borderColor = activeColor;
        textColor   = Colors.white;
        break;
      case BoxState.correct:
        bgColor     = const Color(0xFF4ECBA1);
        borderColor = const Color(0xFF2EA87E);
        textColor   = Colors.white;
        break;
      case BoxState.wrong:
        bgColor     = const Color(0xFFFF5252);
        borderColor = const Color(0xFFD32F2F);
        textColor   = Colors.white;
        break;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width:  size,
      height: size,
      decoration: BoxDecoration(
        color:        bgColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        state == BoxState.empty ? '' : letter,
        style: TextStyle(
          fontSize:   fontSize,
          fontWeight: FontWeight.w900,
          color:      textColor,
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════
// ANSWER BOXES ROW
// ════════════════════════════════════════════════
class SpellAnswerRow extends StatelessWidget {
  final SpellItController controller;
  final SpellItResponsive r;

  const SpellAnswerRow({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final word     = controller.currentWord;
    final letters  = word.word.split('');

    return AnimatedBuilder(
      animation: controller.answerEntranceController,
      builder: (_, child) => Opacity(
        opacity: controller.answerFade.value,
        child:   Transform.translate(
          offset: Offset(0, controller.answerSlide.value),
          child:  child,
        ),
      ),
      child: AnimatedBuilder(
        animation: controller.wrongShakeController,
        builder: (_, child) => Transform.translate(
          offset: Offset(
            controller.isWrongFlash
              ? controller.wrongShake.value
              : 0,
            0,
          ),
          child: child,
        ),
        child: AnimatedBuilder(
          animation: controller.correctScaleController,
          builder: (_, child) => Transform.scale(
            scale: controller.boxStates.every(
              (s) => s == BoxState.correct,
            )
              ? controller.correctScale.value
              : 1.0,
            child: child,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(letters.length, (i) {
              final letter = i < controller.tapped.length
                ? controller.tapped[i].letter
                : '';
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: r.answerBoxSpacing * 0.5,
                ),
                child: SpellAnswerBox(
                  state:       controller.boxStates[i],
                  letter:      letter,
                  size:        r.answerBoxSize,
                  radius:      r.answerBoxRadius,
                  fontSize:    r.answerFontSize,
                  borderWidth: r.answerBorderWidth,
                  activeColor: word.color,
                  lightColor:  word.lightColor,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}