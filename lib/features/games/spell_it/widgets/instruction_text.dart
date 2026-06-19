
import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/spell_it/spell_it_responsive.dart';

class SpellInstruction extends StatelessWidget {
  final SpellItResponsive r;
  const SpellInstruction({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Tap letters to spell the word! 👆',
      style: TextStyle(
        fontSize:   r.instructionFontSize,
        fontWeight: FontWeight.w700,
        color:      const Color(0xFF888888),
      ),
    );
  }
}