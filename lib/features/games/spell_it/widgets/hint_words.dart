
import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/spell_it/spell_it_controller.dart';
import 'package:kids_learning/features/games/spell_it/spell_it_responsive.dart';

class SpellWordHint extends StatelessWidget {
  final SpellItController controller;
  final SpellItResponsive r;

  const SpellWordHint({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      controller.currentWord.hint,
      style: TextStyle(
        fontSize:   r.hintFontSize,
        fontWeight: FontWeight.w800,
        color:      controller.currentWord.color,
      ),
    );
  }
}