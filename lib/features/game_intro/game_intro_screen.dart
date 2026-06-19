import 'package:flutter/material.dart';
import 'package:kids_learning/features/game_intro/widgets/game_preview_zone.dart';
import 'package:kids_learning/features/game_intro/widgets/stars_row.dart';
import 'package:kids_learning/features/game_intro/widgets/start_button.dart';
import 'package:kids_learning/features/game_intro/widgets/title_subtitle.dart';
import 'package:kids_learning/features/game_intro/widgets/top_bar.dart';
import 'package:kids_learning/features/games/shared/game_shell_screen.dart';
import 'game_intro_controller.dart';
import 'game_intro_responsive.dart';

class GameIntroScreen extends StatefulWidget {
  final String ageGroup;
  const GameIntroScreen({super.key, required this.ageGroup});

  @override
  State<GameIntroScreen> createState() => _GameIntroScreenState();
}

class _GameIntroScreenState extends State<GameIntroScreen>
    with TickerProviderStateMixin {

  final _controller = GameIntroController();

  @override
  void initState() {
    super.initState();
    _controller.init(this, widget.ageGroup);
  }

  @override
  void dispose() {
    _controller.disposeAll();
    super.dispose();
  }

  // ── Navigate to game & refresh stars on return ─
 /* Future<void> _onStartTapped() async {
    _controller.onStartPressed();
    await Future.delayed(const Duration(milliseconds: 150));
    if (!mounted) return;
    await Navigator.pushNamed(
      context,
      '/game',
      arguments: _controller.config,
    );
    _controller.refreshBestStars();
  }

  void _onBack() {
    Navigator.pushReplacementNamed(context, '/age-select');
  }
*/

  Future<void> _onStartTapped() async {
    _controller.onStartPressed();
    await Future.delayed(const Duration(milliseconds: 150));
    if (!mounted) return;

    // ✅ Direct navigation — no named route needed
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GameShellScreen(
          config: _controller.config,
        ),
      ),
    );

    // Refresh stars when coming back
    _controller.refreshBestStars();
  }

  void _onBack() {
    Navigator.pushReplacementNamed(context, '/age-select');
  }

  void _onSettings() {
  Navigator.pushNamed(context, '/settings');
}

  @override
  Widget build(BuildContext context) {
    final r = GameIntroResponsive(MediaQuery.of(context).size);
    final c = _controller.config;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller.masterFadeController,
        builder: (_, child) => Opacity(
          opacity: _controller.masterFade.value,
          child: child,
        ),
        child: Container(
          width:  double.infinity,
          height: double.infinity,
          color:  c.primaryColor,
          child: Stack(
            children: [

              // ── Wave decoration ──────────────────
              GameIntroWave(r: r),

              // ── Safe area content ────────────────
              SafeArea(
                child: Column(
                  children: [

                    // Top bar
                    GameIntroTopBar(
                      controller: _controller,
                      r:          r,
                      onBack:     _onBack,
                      onSettings:  _onSettings,  
                    ),

                    SizedBox(height: r.titleTopGap),

                    // Game title + subtitle
                    GameIntroTitle(
                      controller: _controller,
                      r:          r,
                    ),

                    SizedBox(height: r.previewTopGap),

                    // Mini preview zone
                    GameIntroPreview(
                      controller: _controller,
                      r:          r,
                    ),

                    SizedBox(height: r.startBtnTopGap),

                    // START button
                    GameIntroStartButton(
                      controller: _controller,
                      r:          r,
                      onTap:      _onStartTapped,
                    ),

                    SizedBox(height: r.bestTopGap),

                    // Best stars
                    GameIntroBestStars(
                      controller: _controller,
                      r:          r,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}