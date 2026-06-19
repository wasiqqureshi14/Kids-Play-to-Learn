import 'package:flutter/material.dart';

class ShapeMatchResponsive {
  final Size size;
  const ShapeMatchResponsive(this.size);

  double get width  => size.width;
  double get height => size.height;

  // ── Round indicator ────────────────────────────
  double get roundFontSize       => width  * 0.038;
  double get roundTopGap         => height * 0.012;

  // ── Draggable shape ────────────────────────────
  double get dragAreaHeight      => height * 0.340;
  double get shapeSize           => width  * 0.280;
  double get shapeLabelSize      => width  * 0.038;
  double get shapeLabelGap       => height * 0.01;
  double get shapeEmojiSize      => width  * 0.140;

  // ── Drop zones ─────────────────────────────────
  double get dropZoneAreaHeight  => height * 0.300;
  double get dropZoneSize        => width  * 0.240;
  double get dropZoneRadius      => width  * 0.048;
  double get dropZoneSpacing     => width  * 0.028;
  double get dropZoneLabelSize   => width  * 0.030;
  double get dropZoneLabelGap    => height * 0.007;
  double get dropZoneEmojiSize   => width  * 0.090;
  double get dropZoneBorderWidth => width  * 0.006;

  // ── Feedback ───────────────────────────────────
  double get feedbackIconSize    => width  * 0.180;
  double get feedbackFontSize    => width  * 0.052;

  // ── Progress dots ──────────────────────────────
  double get dotSize             => width  * 0.022;
  double get dotSpacing          => width  * 0.014;
  double get dotAreaTopGap       => height * 0.018;
}