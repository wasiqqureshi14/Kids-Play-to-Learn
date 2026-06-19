import 'package:flutter/material.dart';

class GameIntroResponsive {
  final Size size;
  const GameIntroResponsive(this.size);

  double get width  => size.width;
  double get height => size.height;

  // ── Top Bar ────────────────────────────────────
  double get topBarPadding       => width  * 0.045;
  double get topBarTopPadding    => height * 0.015;
  double get backBtnSize         => width  * 0.088;
  double get backIconSize        => width  * 0.048;
  double get agePillFontSize     => width  * 0.030;
  double get agePillPadV         => height * 0.006;
  double get agePillPadH         => width  * 0.040;
  double get agePillRadius       => width  * 0.050;

  // ── Title ──────────────────────────────────────
  double get titleTopGap         => height * 0.018;
  double get titleFontSize       => width  * 0.085;
  double get subtitleFontSize    => width  * 0.036;
  double get subtitleTopGap      => height * 0.006;

  // ── Preview Zone ───────────────────────────────
  double get previewTopGap       => height * 0.028;
  double get previewWidth        => width  * 0.820;
  double get previewHeight       => height * 0.270;
  double get previewRadius       => width  * 0.060;

  // Shape Match preview
  double get shapeSize           => width  * 0.130;
  double get shapeRadius         => width  * 0.030;
  double get dropZoneSize        => width  * 0.115;
  double get dropZoneRadius      => width  * 0.028;
  double get dropZoneSpacing     => width  * 0.035;

  // ABC preview
  double get letterCardW         => width  * 0.135;
  double get letterCardH         => height * 0.115;
  double get letterCardRadius    => width  * 0.032;
  double get letterFontSize      => width  * 0.075;
  double get hintFontSize        => width  * 0.030;
  double get hintPadV            => height * 0.008;
  double get hintPadH            => width  * 0.045;
  double get hintRadius          => width  * 0.025;

  // Spell It preview
  double get wordImageSize       => width  * 0.090;
  double get answerBoxSize       => width  * 0.095;
  double get answerBoxRadius     => width  * 0.022;
  double get answerBoxFontSize   => width  * 0.048;
  double get answerBoxSpacing    => width  * 0.022;
  double get choiceBoxSize       => width  * 0.078;
  double get choiceBoxRadius     => width  * 0.018;
  double get choiceBoxFontSize   => width  * 0.038;
  double get choiceBoxSpacing    => width  * 0.022;
  double get wordEmojiSize       => width  * 0.075;

  // ── Start Button ───────────────────────────────
  double get startBtnTopGap      => height * 0.032;
  double get startBtnWidth       => width  * 0.580;
  double get startBtnHeight      => height * 0.078;
  double get startBtnRadius      => width  * 0.080;
  double get startBtnFontSize    => width  * 0.062;
  double get startIconSize       => width  * 0.048;

  // ── Best Stars ─────────────────────────────────
  double get bestTopGap          => height * 0.020;
  double get bestFontSize        => width  * 0.034;
  double get bestStarSize        => width  * 0.038;

  // ── Wave decoration ────────────────────────────
  double get waveHeight          => height * 0.080;
}