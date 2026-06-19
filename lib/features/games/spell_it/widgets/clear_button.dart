
import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/spell_it/spell_it_controller.dart';
import 'package:kids_learning/features/games/spell_it/spell_it_responsive.dart';

class SpellClearButton extends StatelessWidget {
  final SpellItController controller;
  final SpellItResponsive r;

  const SpellClearButton({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final word     = controller.currentWord;
    final hasInput = controller.tapped.isNotEmpty;

    return GestureDetector(
      onTap: hasInput ? controller.clearAnswer : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width:  r.clearBtnWidth,
        height: r.clearBtnHeight,
        decoration: BoxDecoration(
          color: hasInput
            ? word.lightColor
            : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(r.clearBtnRadius),
          border: Border.all(
            color: hasInput
              ? word.color.withOpacity(0.35)
              : const Color(0xFFDDDDDD),
            width: 2.0,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          '⌫   Clear',
          style: TextStyle(
            fontSize:   r.clearBtnFontSize,
            fontWeight: FontWeight.w800,
            color: hasInput
              ? word.color
              : const Color(0xFFBBBBBB),
          ),
        ),
      ),
    );
  }
}