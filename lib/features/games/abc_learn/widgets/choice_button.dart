import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/abc_learn/abc_learn_controller.dart';
import 'package:kids_learning/features/games/abc_learn/abc_learn_responsive.dart';

class AbcChoiceButton extends StatelessWidget {
  final LetterModel          letter;
  final int                  index;
  final AbcLearnController   controller;
  final AbcLearnResponsive   r;
  final VoidCallback         onTap;

  const AbcChoiceButton({
    super.key,
    required this.letter,
    required this.index,
    required this.controller,
    required this.r,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final state     = controller.choiceStates[index];
    final isCorrect = state == ChoiceState.correct;
    final isWrong   = state == ChoiceState.wrong;
    final isShaking = controller.shakingIndex == index;

    // Colors based on state
    final bgColor = isCorrect
      ? const Color(0xFF4ECBA1)
      : isWrong
        ? const Color(0xFFFF5252)
        : Colors.white;

    final letterColor = isCorrect || isWrong
      ? Colors.white
      : letter.color;

    final borderColor = isCorrect
      ? const Color(0xFF2EA87E)
      : isWrong
        ? const Color(0xFFD32F2F)
        : letter.color.withOpacity(0.30);

    return AnimatedBuilder(
      animation: controller.choicesEntranceController,
      builder: (_, child) => Opacity(
        opacity: controller.choicesFade.value,
        child:   Transform.translate(
          offset: Offset(0, controller.choicesSlide.value),
          child:  child,
        ),
      ),
      child: AnimatedBuilder(
        animation: controller.wrongShakeController,
        builder: (_, child) => Transform.translate(
          offset: Offset(
            isShaking ? controller.wrongShake.value : 0,
            0,
          ),
          child: child,
        ),
        child: GestureDetector(
          onTap: state == ChoiceState.normal ? onTap : null,
          child: AnimatedBuilder(
            animation: controller.correctScaleController,
            builder: (_, child) => Transform.scale(
              scale: isCorrect
                ? controller.correctScale.value
                : 1.0,
              child: child,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width:  r.choiceBtnWidth,
              height: r.choiceBtnHeight,
              decoration: BoxDecoration(
                color:        bgColor,
                borderRadius: BorderRadius.circular(r.choiceBtnRadius),
                border: Border.all(
                  color: borderColor,
                  width: r.choiceBorderWidth,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isCorrect
                      ? const Color(0xFF4ECBA1).withOpacity(0.35)
                      : isWrong
                        ? const Color(0xFFFF5252).withOpacity(0.35)
                        : letter.color.withOpacity(0.15),
                    blurRadius: r.choiceShadowBlur,
                    offset:     const Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                letter.letter,
                style: TextStyle(
                  fontSize:   r.choiceLetterSize,
                  fontWeight: FontWeight.w900,
                  color:      letterColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════
// CHOICES ROW  (all 3 buttons)
// ════════════════════════════════════════════════
class AbcChoicesRow extends StatelessWidget {
  final AbcLearnController controller;
  final AbcLearnResponsive  r;

  const AbcChoicesRow({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final choices = controller.currentRound.choices;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: r.choiceBtnSpacing * 0.5),
          child: AbcChoiceButton(
            letter:     choices[i],
            index:      i,
            controller: controller,
            r:          r,
            onTap:      () => controller.onChoiceTapped(i),
          ),
        );
      }),
    );
  }
}