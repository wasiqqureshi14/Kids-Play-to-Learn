import 'package:flutter/material.dart';
import 'package:kids_learning/features/game_intro/game_intro_controller.dart';
import 'package:kids_learning/features/game_intro/game_intro_responsive.dart';

class GameIntroPreview extends StatelessWidget {
  final GameIntroController controller;
  final GameIntroResponsive r;

  const GameIntroPreview({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.previewController,
      builder: (_, child) => Opacity(
        opacity: controller.previewFade.value,
        child: Transform.scale(
          scale: controller.previewScale.value,
          child: child,
        ),
      ),
      child: Container(
        width:  r.previewWidth,
        height: r.previewHeight,
        decoration: BoxDecoration(
          color:        Colors.white.withOpacity(0.18),
          borderRadius: BorderRadius.circular(r.previewRadius),
        ),
        child: _buildPreviewContent(),
      ),
    );
  }

  Widget _buildPreviewContent() {
    switch (controller.config.previewType) {
      case PreviewType.shapeMatch:
        return ShapeMatchPreview(controller: controller, r: r);
      case PreviewType.abcLearn:
        return AbcLearnPreview(controller: controller, r: r);
      case PreviewType.spellIt:
        return SpellItPreview(controller: controller, r: r);
    }
  }
}

// ════════════════════════════════════════════════
// SHAPE MATCH PREVIEW
// ════════════════════════════════════════════════
class ShapeMatchPreview extends StatelessWidget {
  final GameIntroController controller;
  final GameIntroResponsive r;

  const ShapeMatchPreview({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [

        // Top row — floating shapes
        Positioned(
          top: r.previewHeight * 0.12,
          child: AnimatedBuilder(
            animation: controller.floatOffset,
            builder: (_, child) => Transform.translate(
              offset: Offset(0, controller.floatOffset.value),
              child: child,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Square(size: r.shapeSize, color: Colors.white.withOpacity(0.90)),
                SizedBox(width: r.shapeSize * 0.45),
                _Circle(size: r.shapeSize, color: const Color(0xFFFFE0A0)),
                SizedBox(width: r.shapeSize * 0.45),
                _Diamond(size: r.shapeSize, color: Colors.white.withOpacity(0.70)),
              ],
            ),
          ),
        ),

        // Bottom row — drop zones
        Positioned(
          bottom: r.previewHeight * 0.10,
          child: Row(
            children: [
              _DropZone(size: r.dropZoneSize, shape: DropShape.square),
              SizedBox(width: r.dropZoneSpacing),
              _DropZone(size: r.dropZoneSize, shape: DropShape.circle),
              SizedBox(width: r.dropZoneSpacing),
              _DropZone(size: r.dropZoneSize, shape: DropShape.diamond),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Shape widgets ─────────────────────────────
class _Square extends StatelessWidget {
  final double size;
  final Color color;
  const _Square({required this.size, required this.color});

  @override
  Widget build(BuildContext context) => Container(
    width: size, height: size,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(size * 0.22),
    ),
  );
}

class _Circle extends StatelessWidget {
  final double size;
  final Color color;
  const _Circle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) => Container(
    width: size, height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

class _Diamond extends StatelessWidget {
  final double size;
  final Color color;
  const _Diamond({required this.size, required this.color});

  @override
  Widget build(BuildContext context) => Transform.rotate(
    angle: 0.785,
    child: Container(
      width: size * 0.75, height: size * 0.75,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size * 0.12),
      ),
    ),
  );
}

enum DropShape { square, circle, diamond }

class _DropZone extends StatelessWidget {
  final double size;
  final DropShape shape;
  const _DropZone({required this.size, required this.shape});

  @override
  Widget build(BuildContext context) {
    final decoration = shape == DropShape.circle
      ? BoxDecoration(
          color:  Colors.white.withOpacity(0.20),
          shape:  BoxShape.circle,
          border: Border.all(
            color: Colors.white.withOpacity(0.65),
            width: 2.5,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        )
      : BoxDecoration(
          color: Colors.white.withOpacity(0.20),
          borderRadius: BorderRadius.circular(size * 0.22),
          border: Border.all(
            color: Colors.white.withOpacity(0.65),
            width: 2.5,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        );

    Widget child = Container(
      width: size, height: size,
      decoration: decoration,
    );

    return shape == DropShape.diamond
      ? Transform.rotate(angle: 0.785, child: child)
      : child;
  }
}

// ════════════════════════════════════════════════
// ABC LEARN PREVIEW
// ════════════════════════════════════════════════
class AbcLearnPreview extends StatelessWidget {
  final GameIntroController controller;
  final GameIntroResponsive r;

  const AbcLearnPreview({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [

        // Letter cards row — float animation
        Positioned(
          top: r.previewHeight * 0.10,
          child: AnimatedBuilder(
            animation: controller.floatOffset,
            builder: (_, child) => Transform.translate(
              offset: Offset(0, controller.floatOffset.value * 0.6),
              child: child,
            ),
            child: Row(
              children: [
                _LetterCard(
                  letter:     'A',
                  isSelected: true,
                  width:      r.letterCardW,
                  height:     r.letterCardH,
                  radius:     r.letterCardRadius,
                  fontSize:   r.letterFontSize,
                  primaryColor: controller.config.primaryColor,
                ),
                SizedBox(width: r.letterCardW * 0.18),
                _LetterCard(
                  letter:     'B',
                  isSelected: false,
                  width:      r.letterCardW,
                  height:     r.letterCardH,
                  radius:     r.letterCardRadius,
                  fontSize:   r.letterFontSize,
                  primaryColor: controller.config.primaryColor,
                ),
                SizedBox(width: r.letterCardW * 0.18),
                _LetterCard(
                  letter:     'C',
                  isSelected: false,
                  width:      r.letterCardW,
                  height:     r.letterCardH,
                  radius:     r.letterCardRadius,
                  fontSize:   r.letterFontSize,
                  primaryColor: controller.config.primaryColor,
                ),
              ],
            ),
          ),
        ),

        // Hint text at bottom
        Positioned(
          bottom: r.previewHeight * 0.10,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical:   r.hintPadV,
              horizontal: r.hintPadH,
            ),
            decoration: BoxDecoration(
              color:        Colors.white.withOpacity(0.20),
              borderRadius: BorderRadius.circular(r.hintRadius),
            ),
            child: Text(
              'Find:  A  is for Apple 🍎',
              style: TextStyle(
                fontSize:   r.hintFontSize,
                fontWeight: FontWeight.w800,
                color:      Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LetterCard extends StatelessWidget {
  final String letter;
  final bool   isSelected;
  final double width, height, radius, fontSize;
  final Color  primaryColor;

  const _LetterCard({
    required this.letter,
    required this.isSelected,
    required this.width,
    required this.height,
    required this.radius,
    required this.fontSize,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  width,
      height: height,
      decoration: BoxDecoration(
        color: isSelected
          ? Colors.white
          : Colors.white.withOpacity(0.28),
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: TextStyle(
          fontSize:   fontSize,
          fontWeight: FontWeight.w900,
          color: isSelected
            ? primaryColor
            : Colors.white,
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════
// SPELL IT PREVIEW
// ════════════════════════════════════════════════
class SpellItPreview extends StatelessWidget {
  final GameIntroController controller;
  final GameIntroResponsive r;

  const SpellItPreview({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [

        // Word image emoji — floats
        Positioned(
          top: r.previewHeight * 0.08,
          child: AnimatedBuilder(
            animation: controller.floatOffset,
            builder: (_, child) => Transform.translate(
              offset: Offset(0, controller.floatOffset.value),
              child: child,
            ),
            child: Text(
              '🐱',
              style: TextStyle(fontSize: r.wordEmojiSize),
            ),
          ),
        ),

        // Answer boxes — C A ?
        Positioned(
          top: r.previewHeight * 0.40,
          child: Row(
            children: [
              _AnswerBox(
                letter:       'C',
                isFilled:     true,
                size:         r.answerBoxSize,
                radius:       r.answerBoxRadius,
                fontSize:     r.answerBoxFontSize,
                primaryColor: controller.config.primaryColor,
              ),
              SizedBox(width: r.answerBoxSpacing),
              _AnswerBox(
                letter:       'A',
                isFilled:     true,
                size:         r.answerBoxSize,
                radius:       r.answerBoxRadius,
                fontSize:     r.answerBoxFontSize,
                primaryColor: controller.config.primaryColor,
              ),
              SizedBox(width: r.answerBoxSpacing),
              _AnswerBox(
                letter:       '?',
                isFilled:     false,
                size:         r.answerBoxSize,
                radius:       r.answerBoxRadius,
                fontSize:     r.answerBoxFontSize,
                primaryColor: controller.config.primaryColor,
              ),
            ],
          ),
        ),

        // Choice letters bottom row
        Positioned(
          bottom: r.previewHeight * 0.09,
          child: Row(
            children: [
              _ChoiceBox(letter: 'X', size: r.choiceBoxSize, radius: r.choiceBoxRadius, fontSize: r.choiceBoxFontSize, isCorrect: false),
              SizedBox(width: r.choiceBoxSpacing),
              _ChoiceBox(letter: 'T', size: r.choiceBoxSize, radius: r.choiceBoxRadius, fontSize: r.choiceBoxFontSize, isCorrect: true),
              SizedBox(width: r.choiceBoxSpacing),
              _ChoiceBox(letter: 'M', size: r.choiceBoxSize, radius: r.choiceBoxRadius, fontSize: r.choiceBoxFontSize, isCorrect: false),
            ],
          ),
        ),
      ],
    );
  }
}

class _AnswerBox extends StatelessWidget {
  final String letter;
  final bool   isFilled;
  final double size, radius, fontSize;
  final Color  primaryColor;

  const _AnswerBox({
    required this.letter,
    required this.isFilled,
    required this.size,
    required this.radius,
    required this.fontSize,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        color: isFilled
          ? Colors.white
          : Colors.white.withOpacity(0.20),
        borderRadius: BorderRadius.circular(radius),
        border: isFilled ? null : Border.all(
          color: Colors.white.withOpacity(0.65),
          width: 2.5,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: TextStyle(
          fontSize:   fontSize,
          fontWeight: FontWeight.w900,
          color: isFilled ? primaryColor : Colors.white70,
        ),
      ),
    );
  }
}

class _ChoiceBox extends StatelessWidget {
  final String letter;
  final double size, radius, fontSize;
  final bool   isCorrect;

  const _ChoiceBox({
    required this.letter,
    required this.size,
    required this.radius,
    required this.fontSize,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        color: isCorrect
          ? Colors.white.withOpacity(0.85)
          : Colors.white.withOpacity(0.28),
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: TextStyle(
          fontSize:   fontSize,
          fontWeight: FontWeight.w900,
          color: isCorrect
            ? const Color(0xFF2EA87E)
            : Colors.white,
        ),
      ),
    );
  }
}