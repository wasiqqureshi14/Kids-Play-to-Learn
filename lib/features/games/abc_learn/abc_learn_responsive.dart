
import 'package:flutter/material.dart';

class AbcLearnResponsive {
  final Size size;

  const AbcLearnResponsive(this.size);

  double get width => size.width;
  double get height => size.height;

  double get roundFontSize => width * 0.038;
  double get roundTopGap => height * 0.010;

  double get dotSize => width * 0.022;
  double get dotSpacing => width * 0.014;
  double get dotAreaTopGap => height * 0.015;

  double get letterCardSize       => width  * 0.380;
  double get letterCardRadius     => width  * 0.060;
  double get letterFontSize       => width  * 0.220;
  double get letterCardTopGap     => height * 0.018;
  double get letterShadowBlur     => width  * 0.060;

  // ── Emoji / word row ───────────────────────────
  double get emojiSize            => width  * 0.115;
  double get wordFontSize         => width  * 0.048;
  double get wordGap              => width  * 0.025;
  double get emojiRowTopGap       => height * 0.018;
  double get emojiRowPadH         => width  * 0.055;
  double get emojiRowPadV         => height * 0.012;
  double get emojiRowRadius       => width  * 0.040;

  // ── Instruction text ───────────────────────────
  double get instructionFontSize  => width  * 0.036;
  double get instructionTopGap    => height * 0.020;

  // ── Choice buttons ─────────────────────────────
  double get choiceAreaTopGap     => height * 0.022;
  double get choiceBtnWidth       => width  * 0.240;
  double get choiceBtnHeight      => height * 0.110;
  double get choiceBtnRadius      => width  * 0.048;
  double get choiceBtnSpacing     => width  * 0.030;
  double get choiceLetterSize     => width  * 0.110;
  double get choiceShadowBlur     => width  * 0.040;
  double get choiceBorderWidth    => width  * 0.006;

  // ── Feedback ───────────────────────────────────
  double get feedbackIconSize     => width  * 0.160;
}