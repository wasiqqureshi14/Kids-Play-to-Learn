import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/abc_learn/abc_learn_controller.dart';
import 'package:kids_learning/features/games/abc_learn/abc_learn_responsive.dart';

class AbcEmojiRow extends StatelessWidget {
  final AbcLearnController controller;
  final AbcLearnResponsive  r;

  const AbcEmojiRow({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final letter = controller.currentRound.correct;

    return AnimatedBuilder(
      animation: controller.emojiEntranceController,
      builder: (_, child) => Opacity(
        opacity: controller.emojiFade.value,
        child:   Transform.translate(
          offset: Offset(0, controller.emojiSlide.value),
          child:  child,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: r.emojiRowPadH,
          vertical:   r.emojiRowPadV,
        ),
        decoration: BoxDecoration(
          color:        letter.color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(r.emojiRowRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              letter.emoji,
              style: TextStyle(fontSize: r.emojiSize),
            ),
            SizedBox(width: r.wordGap),
            Text(
              letter.word,
              style: TextStyle(
                fontSize:   r.wordFontSize,
                fontWeight: FontWeight.w800,
                color:      letter.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AbcInstruction extends StatelessWidget {
  final AbcLearnResponsive r;

  const AbcInstruction({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Tap the correct letter! 👆',
      style: TextStyle(
        fontSize:   r.instructionFontSize,
        fontWeight: FontWeight.w700,
        color:      const Color(0xFF888888),
      ),
    );
  }
}