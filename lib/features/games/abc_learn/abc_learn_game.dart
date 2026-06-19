import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/abc_learn/widgets/choice_button.dart';
import 'package:kids_learning/features/games/abc_learn/widgets/emoji_row.dart';
import 'package:kids_learning/features/games/abc_learn/widgets/letter_card.dart';
import 'package:kids_learning/features/games/abc_learn/widgets/round_indicator.dart';
import 'abc_learn_controller.dart';
import 'abc_learn_responsive.dart';

class AbcLearnGame extends StatefulWidget {
  final Function(int) onScore;
  final Function(int) onSetMax;
  final VoidCallback  onGameOver;

  const AbcLearnGame({
    super.key,
    required this.onScore,
    required this.onSetMax,
    required this.onGameOver,
  });

  @override
  State<AbcLearnGame> createState() => _AbcLearnGameState();
}

class _AbcLearnGameState extends State<AbcLearnGame>
    with TickerProviderStateMixin {

  final _controller = AbcLearnController();

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
    final r = AbcLearnResponsive(MediaQuery.of(context).size);

    return ListenableBuilder(
      listenable: _controller,
      builder: (_, _) => Column(
        children: [

          // Round indicator
          AbcRoundIndicator(controller: _controller, r: r),

          SizedBox(height: r.roundTopGap),

          // Progress dots
        //  AbcProgressDots(controller: _controller, r: r),

          //SizedBox(height: r.letterCardTopGap),

          // Big letter card
          AbcLetterCard(controller: _controller, r: r),

          SizedBox(height: r.emojiRowTopGap),

          // Emoji + word
          AbcEmojiRow(controller: _controller, r: r),

          SizedBox(height: r.instructionTopGap),

          // Instruction
          AbcInstruction(r: r),

          SizedBox(height: r.choiceAreaTopGap),

          // 3 Choice buttons
          AbcChoicesRow(controller: _controller, r: r),

          const Spacer(),
        ],
      ),
    );
  }
}