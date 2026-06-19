
import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/spell_it/spell_it_controller.dart';
import 'package:kids_learning/features/games/spell_it/spell_it_responsive.dart';

class SpellChoiceButton extends StatelessWidget {
  final String         letter;
  final int            index;
  final ChoiceState    state;
  final SpellItController controller;
  final SpellItResponsive r;
  final VoidCallback   onTap;

  const SpellChoiceButton({
    super.key,
    required this.letter,
    required this.index,
    required this.state,
    required this.controller,
    required this.r,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final word    = controller.currentWord;
    final isUsed  = state == ChoiceState.used;

    final bgColor = isUsed
      ? word.lightColor
      : Colors.white;

    final borderColor = isUsed
      ? word.color.withOpacity(0.20)
      : word.color.withOpacity(0.35);

    final textColor = isUsed
      ? word.color.withOpacity(0.35)
      : word.color;

    return AnimatedBuilder(
      animation: controller.choicesEntranceController,
      builder: (_, child) => Opacity(
        opacity: controller.choicesFade.value,
        child:   Transform.translate(
          offset: Offset(0, controller.choicesSlide.value),
          child:  child,
        ),
      ),
      child: GestureDetector(
        onTap: isUsed ? null : onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width:  r.choiceBtnSize,
          height: r.choiceBtnSize,
          decoration: BoxDecoration(
            color:        bgColor,
            borderRadius: BorderRadius.circular(r.choiceBtnRadius),
            border: Border.all(
              color: borderColor,
              width: r.choiceBorderWidth,
            ),
            boxShadow: isUsed ? [] : [
              BoxShadow(
                color:      word.color.withOpacity(0.15),
                blurRadius: 8,
                offset:     const Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            letter,
            style: TextStyle(
              fontSize:   r.choiceFontSize,
              fontWeight: FontWeight.w900,
              color:      textColor,
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════
// CHOICES GRID
// ════════════════════════════════════════════════
class SpellChoicesGrid extends StatelessWidget {
  final SpellItController controller;
  final SpellItResponsive r;

  const SpellChoicesGrid({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing:   r.choiceBtnSpacing,
      runSpacing:r.choiceBtnSpacing,
      alignment: WrapAlignment.center,
      children: List.generate(
        controller.shuffledChoices.length,
        (i) => SpellChoiceButton(
          letter:     controller.shuffledChoices[i],
          index:      i,
          state:      controller.choiceStates[i],
          controller: controller,
          r:          r,
          onTap:      () => controller.onChoiceTapped(i),
        ),
      ),
    );
  }
}