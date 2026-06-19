import 'package:flutter/material.dart';
import 'splash_controller.dart';
import 'splash_responsive.dart';

// ════════════════════════════════════════════════
// BACKGROUND STARS
// ════════════════════════════════════════════════
class SplashStars extends StatelessWidget {
  final SplashResponsive r;
  const SplashStars({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: SplashResponsive.starPositions.asMap().entries.map((e) {
        return Positioned(
          left: r.width  * e.value[0],
          top:  r.height * e.value[1],
          child: Container(
            width:  r.starDotSize(e.key),
            height: r.starDotSize(e.key),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ════════════════════════════════════════════════
// CLOUD
// ════════════════════════════════════════════════
class SplashCloud extends StatelessWidget {
  final double top;
  final double? left;
  final double? right;
  final double width;
  final double height;

  const SplashCloud({
    super.key,
    required this.top,
    this.left,
    this.right,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top, left: left, right: right,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════
// FLOATING EMOJI
// ════════════════════════════════════════════════
class SplashFloatyEmoji extends StatelessWidget {
  final String emoji;
  final double top;
  final double? left;
  final double? right;
  final double fontSize;

  const SplashFloatyEmoji({
    super.key,
    required this.emoji,
    required this.top,
    required this.fontSize,
    this.left,
    this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top, left: left, right: right,
      child: Text(emoji, style: TextStyle(fontSize: fontSize)),
    );
  }
}

// ════════════════════════════════════════════════
// GROUND CURVE
// ════════════════════════════════════════════════
class SplashGround extends StatelessWidget {
  final double height;
  const SplashGround({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0, left: 0, right: 0,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.07),
          borderRadius: const BorderRadius.vertical(
            top: Radius.elliptical(200, 50),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════
// BEAR EAR
// ════════════════════════════════════════════════
class BearEar extends StatelessWidget {
  final double size;
  final double innerSize;

  const BearEar({
    super.key,
    required this.size,
    required this.innerSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, height: size,
      decoration: const BoxDecoration(
        color: Color(0xFFF7C25E),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: innerSize, height: innerSize,
          decoration: const BoxDecoration(
            color: Color(0xFFF9A03F),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════
// BEAR EYE
// ════════════════════════════════════════════════
class BearEye extends StatelessWidget {
  final double width;
  final double height;
  final double shineSize;

  const BearEye({
    super.key,
    required this.width,
    required this.height,
    required this.shineSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF2C1A0E),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            width: shineSize, height: shineSize,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════
// BEAR FACE
// ════════════════════════════════════════════════
class BearFace extends StatelessWidget {
  final SplashResponsive r;
  const BearFace({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: r.bearSize,
      height: r.bearSize,
      decoration: const BoxDecoration(
        color: Color(0xFFF7C25E),
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [

          // Left eye
          Positioned(
            top: r.eyeTop,
            left: r.eyeSideOffset,
            child: BearEye(
              width: r.eyeWidth,
              height: r.eyeHeight,
              shineSize: r.eyeShineSize,
            ),
          ),

          // Right eye
          Positioned(
            top: r.eyeTop,
            right: r.eyeSideOffset,
            child: BearEye(
              width: r.eyeWidth,
              height: r.eyeHeight,
              shineSize: r.eyeShineSize,
            ),
          ),

          // Nose
          Positioned(
            top: r.noseTop,
            left: 0, right: 0,
            child: Center(
              child: Container(
                width: r.noseWidth,
                height: r.noseHeight,
                decoration: BoxDecoration(
                  color: const Color(0xFFD97B3A),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // Smile
          Positioned(
            top: r.smileTop,
            left: 0, right: 0,
            child: Center(
              child: Container(
                width: r.smileWidth,
                height: r.smileHeight,
                decoration: BoxDecoration(
                  border: const Border(
                    bottom: BorderSide(
                      color: Color(0xFF2C1A0E),
                      width: 4,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════
// FULL MASCOT (bear + ears + glow + spinning stars)
// ════════════════════════════════════════════════
class SplashMascot extends StatelessWidget {
  final SplashController controller;
  final SplashResponsive r;

  const SplashMascot({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.mascotBounce,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, controller.mascotBounce.value),
        child: child,
      ),
      child: SizedBox(
        width: r.mascotSize,
        height: r.mascotSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _Glow(size: r.glowSize),
            Positioned(top: r.earTop, left: r.earSideOffset,
              child: BearEar(size: r.earSize, innerSize: r.earInnerSize)),
            Positioned(top: r.earTop, right: r.earSideOffset,
              child: BearEar(size: r.earSize, innerSize: r.earInnerSize)),
            BearFace(r: r),
            Positioned(top: 0, child: _SpinningStars(controller: controller, fontSize: r.starFontSize)),
          ],
        ),
      ),
    );
  }
}

// ─── Glow behind bear ──────────────────────────
class _Glow extends StatelessWidget {
  final double size;
  const _Glow({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF7C25E).withOpacity(0.45),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ],
      ),
    );
  }
}

// ─── Spinning stars above head ─────────────────
class _SpinningStars extends StatelessWidget {
  final SplashController controller;
  final double fontSize;
  const _SpinningStars({required this.controller, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.starController,
      builder: (context, _) => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (i) => Transform.rotate(
          angle: controller.starController.value * 6.28 + i * 1.0,
          child: Text('⭐', style: TextStyle(fontSize: fontSize)),
        )),
      ),
    );
  }
}

// ════════════════════════════════════════════════
// LOADING DOTS
// ════════════════════════════════════════════════
class SplashLoadingDots extends StatelessWidget {
  final SplashController controller;
  final SplashResponsive r;

  const SplashLoadingDots({
    super.key,
    required this.controller,
    required this.r,
  });

  static const _colors = [
    Color(0xFFF7C25E),
    Color(0xFFFF6B9D),
    Color(0xFF6BCFFF),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.dotsController,
      builder: (context, _) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (i) {
          final t = (controller.dotsController.value - i * 0.2).clamp(0.0, 1.0);
          return Container(
            margin: EdgeInsets.symmetric(horizontal: r.dotSpacing),
            child: Transform.translate(
              offset: Offset(0, -r.dotBounceHeight * t),
              child: Opacity(
                opacity: 0.5 + 0.5 * t,
                child: Container(
                  width: r.dotSize,
                  height: r.dotSize,
                  decoration: BoxDecoration(
                    color: _colors[i],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ════════════════════════════════════════════════
// APP TITLE + SUBTITLE
// ════════════════════════════════════════════════
class SplashTitle extends StatelessWidget {
  final SplashResponsive r;
  const SplashTitle({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'KidSpark!',
          style: TextStyle(
            fontSize: r.titleFontSize,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 1.5,
            shadows: const [
              Shadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 12),
            ],
          ),
        ),
        SizedBox(height: r.titleBottomGap),
        Text(
          'Learn • Play • Grow 🌱',
          style: TextStyle(
            fontSize: r.subtitleFontSize,
            color: Colors.white.withOpacity(0.85),
          ),
        ),
      ],
    );
  }
}