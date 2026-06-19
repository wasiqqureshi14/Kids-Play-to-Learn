import 'package:flutter/material.dart';

class SpellItResponsive {
  final Size size;
  const SpellItResponsive(this.size);

  double get width  => size.width;
  double get height => size.height;

  // ── Round indicator ────────────────────────────
  double get roundFontSize        => width  * 0.036;
  double get roundTopGap          => height * 0.010;

  // ── Progress dots ──────────────────────────────
  double get dotSize              => width  * 0.022;
  double get dotSpacing           => width  * 0.012;
  double get dotAreaTopGap        => height * 0.012;

  // ── Emoji area ─────────────────────────────────
  double get emojiSize            => width  * 0.200;
  double get emojiTopGap          => height * 0.018;
  double get emojiContainerSize   => width  * 0.300;
  double get emojiContainerRadius => width  * 0.060;

  // ── Word hint ──────────────────────────────────
  double get hintFontSize         => width  * 0.038;
  double get hintTopGap           => height * 0.010;

  // ── Answer boxes ───────────────────────────────
  double get answerRowTopGap      => height * 0.022;
  double get answerBoxSize        => width  * 0.130;
  double get answerBoxRadius      => width  * 0.030;
  double get answerBoxSpacing     => width  * 0.018;
  double get answerFontSize       => width  * 0.068;
  double get answerBorderWidth    => width  * 0.006;

  // ── Instruction ────────────────────────────────
  double get instructionFontSize  => width  * 0.032;
  double get instructionTopGap    => height * 0.016;

  // ── Choice buttons ─────────────────────────────
  double get choiceAreaTopGap     => height * 0.020;
  double get choiceBtnSize        => width  * 0.148;
  double get choiceBtnRadius      => width  * 0.032;
  double get choiceBtnSpacing     => width  * 0.018;
  double get choiceFontSize       => width  * 0.068;
  double get choiceBorderWidth    => width  * 0.005;

  // ── Clear button ───────────────────────────────
  double get clearBtnTopGap       => height * 0.018;
  double get clearBtnHeight       => height * 0.052;
  double get clearBtnWidth        => width  * 0.420;
  double get clearBtnRadius       => width  * 0.060;
  double get clearBtnFontSize     => width  * 0.036;
}