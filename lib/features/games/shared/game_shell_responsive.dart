import 'package:flutter/material.dart';

class GameShellResponsive {
  final Size size;
  const GameShellResponsive(this.size);

  double get width  => size.width;
  double get height => size.height;

  // ── Top Bar ────────────────────────────────────
  double get topBarHeight        => height * 0.080;
  double get topBarPadding       => width  * 0.045;
  double get topBarIconSize      => width  * 0.060;
  double get topBarBtnSize       => width  * 0.090;
  double get topBarTitleSize     => width  * 0.048;

  // ── Score Bar ──────────────────────────────────
  double get scoreBarHeight      => height * 0.085;
  double get scoreBarPadH        => width  * 0.045;
  double get scoreBarPadV        => height * 0.010;
  double get scoreBarRadius      => width  * 0.040;
  double get scoreBarMargin      => width  * 0.045;
  double get scoreFontSize       => width  * 0.048;
  double get scoreLabelSize      => width  * 0.028;
  double get scoreIconSize       => width  * 0.055;

  // ── Timer Bar ──────────────────────────────────
  double get timerBarHeight      => height * 0.014;
  double get timerBarRadius      => width  * 0.020;
  double get timerBarMarginH     => width  * 0.045;
  double get timerBarMarginTop   => height * 0.010;

  // ── Game Content Area ──────────────────────────
  double get gameAreaTopGap      => height * 0.015;
  double get gameAreaBottomGap   => height * 0.015;

  // ── Result Dialog ──────────────────────────────
  double get dialogWidth         => width  * 0.820;
  double get dialogRadius        => width  * 0.065;
  double get dialogPadding       => width  * 0.065;
  double get dialogTitleSize     => width  * 0.065;
  double get dialogStarSize      => width  * 0.110;
  double get dialogStarSpacing   => width  * 0.025;
  double get dialogScoreSize     => width  * 0.048;
  double get dialogSubSize       => width  * 0.032;
  double get dialogBtnHeight     => height * 0.068;
  double get dialogBtnRadius     => width  * 0.060;
  double get dialogBtnFontSize   => width  * 0.045;
  double get dialogBtnMarginTop  => height * 0.025;
  double get dialogGapV          => height * 0.018;

  // ── Pause Dialog ───────────────────────────────
  double get pauseIconSize       => width  * 0.140;
  double get pauseTitleSize      => width  * 0.058;
  double get pauseBtnHeight      => height * 0.062;
  double get pauseBtnFontSize    => width  * 0.040;
  double get pauseBtnRadius      => width  * 0.050;
  double get pauseBtnMarginTop   => height * 0.015;
}