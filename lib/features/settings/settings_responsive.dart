import 'package:flutter/material.dart';

class SettingsResponsive {
  final Size size;
  const SettingsResponsive(this.size);

  double get width  => size.width;
  double get height => size.height;

  double get topBarHeight      => height * 0.080;
  double get topBarPadding     => width  * 0.045;
  double get topBarIconSize    => width  * 0.060;
  double get topBarTitleSize   => width  * 0.052;
  double get topBarBtnSize     => width  * 0.090;

  double get sectionPadding    => width  * 0.045;
  double get sectionTopGap     => height * 0.030;
  double get sectionTitleSize  => width  * 0.040;

  double get tileHeight        => height * 0.082;
  double get tileRadius        => width  * 0.040;
  double get tileMarginH       => width  * 0.045;
  double get tileMarginV       => height * 0.008;
  double get tileIconSize      => width  * 0.065;
  double get tileTitleSize     => width  * 0.040;
  double get tileSubtitleSize  => width  * 0.030;
  double get tileIconBoxSize   => width  * 0.110;
  double get tileIconBoxRadius => width  * 0.028;

  double get resetBtnHeight    => height * 0.072;
  double get resetBtnRadius    => width  * 0.040;
  double get resetBtnMarginH   => width  * 0.045;
  double get resetBtnFontSize  => width  * 0.040;
  double get resetBtnTopGap    => height * 0.020;

  double get versionFontSize   => width  * 0.030;
  double get versionBottomGap  => height * 0.040;
}