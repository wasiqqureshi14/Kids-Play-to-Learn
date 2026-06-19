import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/spell_it/spell_it_controller.dart';
import 'package:kids_learning/features/games/spell_it/spell_it_responsive.dart';

class SpellEmojiArea extends StatelessWidget {
  final SpellItController controller;
  final SpellItResponsive r;

  const SpellEmojiArea({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final word = controller.currentWord;

    return AnimatedBuilder(
      animation: controller.emojiEntranceController,
      builder: (_, child) => Opacity(
        opacity: controller.emojiFade.value,
        child:   Transform.scale(
          scale: controller.emojiScale.value,
          child: child,
        ),
      ),
      child: Container(
        width:  r.emojiContainerSize,
        height: r.emojiContainerSize,
        decoration: BoxDecoration(
          color:        word.lightColor,
          borderRadius: BorderRadius.circular(r.emojiContainerRadius),
          border: Border.all(
            color: word.color.withOpacity(0.25),
            width: 2.0,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          word.emoji,
          style: TextStyle(fontSize: r.emojiSize),
        ),
      ),
    );
  }
}