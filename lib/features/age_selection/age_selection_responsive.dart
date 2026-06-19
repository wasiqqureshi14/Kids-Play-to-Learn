import 'package:flutter/material.dart';

class AgeSelectionResponsive {
  final Size size;
  const AgeSelectionResponsive(this.size);

  // ── Screen ─────────────────────────────────────
  double get width  => size.width;
  double get height => size.height;

  // ── Header ─────────────────────────────────────
  double get headerTopPadding    => height * 0.07;
  double get headerEmojiSize     => width  * 0.12;
  double get headerTitleSize     => width  * 0.072;
  double get headerSubtitleSize  => width  * 0.038;
  double get headerBottomGap     => height * 0.045;

  // ── Age Cards ──────────────────────────────────
  double get cardWidth           => width  * 0.78;
  double get cardHeight          => height * 0.17;
  double get cardBorderRadius    => width  * 0.060;
  double get cardSpacing         => height * 0.022;
  double get cardEmojiSize       => width  * 0.115;
  double get cardTitleSize       => width  * 0.048;
  double get cardSubtitleSize    => width  * 0.036;
  double get cardArrowSize       => width  * 0.065;
  double get cardHorizontalPad   => width  * 0.055;
  double get cardShadowBlur      => width  * 0.06;
  double get cardShadowOffset    => width  * 0.015;

  // ── Background bubbles ─────────────────────────
  double get bubble1Size         => width  * 0.35;
  double get bubble2Size         => width  * 0.25;
  double get bubble3Size         => width  * 0.20;

  // ── Bottom decoration ──────────────────────────
  double get bottomGrassHeight   => height * 0.10;
}