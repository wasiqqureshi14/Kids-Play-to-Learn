import 'package:flutter/material.dart';
import 'package:kids_learning/core/database/services/audio_services.dart';
import 'splash_controller.dart';
import 'splash_responsive.dart';
import 'splash_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  final _controller = SplashController();
   bool _navigationStarted = false; 

  @override
  void initState() {
    super.initState();
    _controller.init(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigate();
    });
  }

 Future<void> _navigate() async {
    if (_navigationStarted) return;
    _navigationStarted = true;

    // ✅ Waits full 5 seconds
    final lastAge = await _controller.getNavigationRoute();

  AudioService().playMenuMusic();
  
    if (!mounted) return;

    if (lastAge != null) {
      Navigator.pushReplacementNamed(
        context,
        '/game-intro',
        arguments: lastAge,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/age-select');
    }
  }

  @override
  void dispose() {
    _controller.disposeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Responsive object passed to every widget
    final r = SplashResponsive(MediaQuery.of(context).size);

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller.fadeController,
        builder: (context, child) => Opacity(
          opacity: _controller.fadeIn.value,
          child: child,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1A1A6E),
                Color(0xFF3B2F8F),
                Color(0xFFC0447A),
                Color(0xFFF7914B),
              ],
              stops: [0.0, 0.35, 0.7, 1.0],
            ),
          ),
          child: Stack(
            children: [

              // ── Background layer ───────────────
              SplashStars(r: r),

              SplashCloud(top: r.cloud1Top, left: -20, width: r.cloud1Width, height: r.cloud1Height),
              SplashCloud(top: r.cloud2Top, right: -10, width: r.cloud2Width, height: r.cloud2Height),

              SplashFloatyEmoji(emoji: '🌙', top: r.moonTop,    left:  r.moonLeft,    fontSize: r.emojiFontSize),
              SplashFloatyEmoji(emoji: '⭐', top: r.starTop,    right: r.starRight,   fontSize: r.emojiFontSize),
              SplashFloatyEmoji(emoji: '🌈', top: r.rainbowTop, left:  r.rainbowLeft, fontSize: r.emojiFontSize),
              SplashFloatyEmoji(emoji: '🎈', top: r.balloonTop, right: r.balloonRight,fontSize: r.emojiFontSize),

              SplashGround(height: r.groundHeight),

              // ── Center content layer ───────────
              Center(
                child: AnimatedBuilder(
                  animation: _controller.fadeController,
                  builder: (context, child) => Transform.translate(
                    offset: Offset(0, _controller.titleSlide.value),
                    child: child,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SplashMascot(controller: _controller, r: r),
                      SizedBox(height: r.mascotBottomGap),
                      SplashTitle(r: r),
                      SizedBox(height: r.subtitleBottomGap),
                      SplashLoadingDots(controller: _controller, r: r),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}