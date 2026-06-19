import 'package:flutter/material.dart';

class SplashResponsive {
  final Size size;

  const SplashResponsive(this.size);

  // ── Screen dimensions ──────────────────────────
  double get width  => size.width;
  double get height => size.height;

  // ── Mascot ─────────────────────────────────────
  double get mascotSize      => size.width * 0.42;
  double get bearSize        => size.width * 0.32;
  double get earSize         => size.width * 0.10;
  double get earInnerSize    => size.width * 0.06;
  double get eyeWidth        => size.width * 0.04;
  double get eyeHeight       => size.width * 0.05;
  double get noseWidth       => size.width * 0.055;
  double get noseHeight      => size.width * 0.035;
  double get smileWidth      => size.width * 0.09;
  double get smileHeight     => size.width * 0.045;
  double get eyeShineSize    => size.width * 0.013;
  double get glowSize        => size.width * 0.36;
  double get starFontSize    => size.width * 0.045;

  // ── Eye positions ───────────────────────────────
  double get eyeTop          => bearSize * 0.32;
  double get eyeSideOffset   => bearSize * 0.21;
  double get noseTop         => bearSize * 0.52;
  double get smileTop        => bearSize * 0.63;

  // ── Ear positions ───────────────────────────────
  double get earTop          => mascotSize * 0.10;
  double get earSideOffset   => mascotSize * 0.07;

  // ── Typography ─────────────────────────────────
  double get titleFontSize    => size.width * 0.10;
  double get subtitleFontSize => size.width * 0.038;
  double get emojiFontSize    => size.width * 0.06;

  // ── Spacing ────────────────────────────────────
  double get mascotBottomGap  => size.height * 0.025;
  double get titleBottomGap   => size.height * 0.010;
  double get subtitleBottomGap=> size.height * 0.045;

  // ── Loading dots ───────────────────────────────
  double get dotSize          => size.width * 0.030;
  double get dotSpacing       => size.width * 0.013;
  double get dotBounceHeight  => size.height * 0.012;

  // ── Background elements ────────────────────────
  double get cloud1Width      => size.width * 0.28;
  double get cloud1Height     => size.height * 0.045;
  double get cloud1Top        => size.height * 0.12;

  double get cloud2Width      => size.width * 0.22;
  double get cloud2Height     => size.height * 0.035;
  double get cloud2Top        => size.height * 0.19;

  double get groundHeight     => size.height * 0.13;

  // ── Floating emojis positions ──────────────────
  double get moonTop          => size.height * 0.10;
  double get moonLeft         => size.width  * 0.07;

  double get starTop          => size.height * 0.09;
  double get starRight        => size.width  * 0.09;

  double get rainbowTop       => size.height * 0.30;
  double get rainbowLeft      => size.width  * 0.04;

  double get balloonTop       => size.height * 0.27;
  double get balloonRight     => size.width  * 0.05;

  // ── Stars background positions (ratio x, y) ────
  static const List<List<double>> starPositions = [
    [0.12, 0.06], [0.72, 0.10], [0.52, 0.05],
    [0.30, 0.16], [0.88, 0.08], [0.08, 0.22],
    [0.60, 0.14], [0.45, 0.03], [0.80, 0.20],
  ];

  double starDotSize(int index) => 2.0 + (index % 3);
}