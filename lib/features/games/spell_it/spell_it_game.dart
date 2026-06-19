import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/spell_it/widgets/answer_row.dart';
import 'package:kids_learning/features/games/spell_it/widgets/choice_grid.dart';
import 'package:kids_learning/features/games/spell_it/widgets/clear_button.dart';
import 'package:kids_learning/features/games/spell_it/widgets/emoji_area.dart';
import 'package:kids_learning/features/games/spell_it/widgets/hint_words.dart';
import 'package:kids_learning/features/games/spell_it/widgets/instruction_text.dart';
import 'package:kids_learning/features/games/spell_it/widgets/spell_it_round_indicator.dart';
import 'spell_it_controller.dart';
import 'spell_it_responsive.dart';

class SpellItGame extends StatefulWidget {
  final Function(int) onScore;
  final Function(int) onSetMax;
  final VoidCallback  onGameOver;

  const SpellItGame({
    super.key,
    required this.onScore,
    required this.onSetMax,
    required this.onGameOver,
  });

  @override
  State<SpellItGame> createState() => _SpellItGameState();
}

class _SpellItGameState extends State<SpellItGame>
    with TickerProviderStateMixin {

  final _controller = SpellItController();

  @override
  void initState() {
    super.initState();
    _controller.init(
      vsync:      this,
      onScore:    widget.onScore,
      onSetMax:   widget.onSetMax,
      onGameOver: widget.onGameOver,
    );
  }

  @override
  void dispose() {
    _controller.disposeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = SpellItResponsive(MediaQuery.of(context).size);

    return ListenableBuilder(
      listenable: _controller,
      builder: (_, _) => Column(
        children: [

          // Round indicator
          SpellRoundIndicator(controller: _controller, r: r),

          SizedBox(height: r.roundTopGap),

          // Progress dots
         // SpellProgressDots(controller: _controller, r: r),

          //SizedBox(height: r.emojiTopGap),

          // Emoji container
          SpellEmojiArea(controller: _controller, r: r),

          SizedBox(height: r.hintTopGap),

          // Word hint
          SpellWordHint(controller: _controller, r: r),

          SizedBox(height: r.answerRowTopGap),

          // Answer boxes
          SpellAnswerRow(controller: _controller, r: r),

          SizedBox(height: r.instructionTopGap),

          // Instruction
          SpellInstruction(r: r),

          SizedBox(height: r.choiceAreaTopGap),

          // Letter choices grid
          SpellChoicesGrid(controller: _controller, r: r),

          SizedBox(height: r.clearBtnTopGap),

          // Clear button
          SpellClearButton(controller: _controller, r: r),

          const Spacer(),
        ],
      ),
    );
  }
}