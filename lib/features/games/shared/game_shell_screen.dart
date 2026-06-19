

import 'package:flutter/material.dart';
import 'package:kids_learning/features/game_intro/game_intro_screen.dart';
import 'package:kids_learning/features/games/abc_learn/abc_learn_game.dart';
import 'package:kids_learning/features/games/shape_match/shape_match_game.dart';
import 'package:kids_learning/features/games/shared/widgets/result_dialog.dart';
import 'package:kids_learning/features/games/shared/widgets/score_bar.dart';
import 'package:kids_learning/features/games/shared/widgets/shell_top_bar.dart';
import 'package:kids_learning/features/games/shared/widgets/timer_progress_bar.dart';
import 'package:kids_learning/features/games/spell_it/spell_it_game.dart';
import '../../game_intro/game_intro_controller.dart';
import 'game_shell_controller.dart';
import 'game_shell_responsive.dart';

class GameShellScreen extends StatefulWidget {
  final GameConfig config;
  const GameShellScreen({super.key, required this.config});

  @override
  State<GameShellScreen> createState() => _GameShellScreenState();
}

class _GameShellScreenState extends State<GameShellScreen>
    with TickerProviderStateMixin {

  final _controller = GameShellController();

  @override
  void initState() {
    super.initState();
    _controller.init(this, widget.config);
  }

  @override
  void dispose() {
    _controller.disposeAll();
    super.dispose();
  }

  // ── Navigation ─────────────────────────────────
  void _onBack() {
    _controller.pauseGame();
    Navigator.pop(context);
  }

  void _onPause() {
    _controller.pauseGame();
  }

  void _onResume() {
    _controller.resumeGame();
  }

  void _onPlayAgain() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => GameShellScreen(config: widget.config),
      ),
    );
  }

  void _onHome() {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => GameIntroScreen(
        ageGroup: widget.config.ageGroup,
      ),
    ),
    (route) => false,   // removes all previous routes
  );
}

void _onSettings() {
  _controller.pauseGame();    // ← pause game when settings opens
  Navigator.pushNamed(context, '/settings').then((_) {
    // ← resume game when coming back from settings
    if (_controller.isPaused) {
      _controller.resumeGame();
    }
  });
}

  // ── Game content switcher ──────────────────────
  Widget _buildGameContent() {
    switch (widget.config.previewType) {
      case PreviewType.shapeMatch:
        return ShapeMatchGame(
          onScore:      (pts) => _controller.addScore(pts),
          onSetMax:     (max) => _controller.setMaxScore(max),
          onGameOver:   ()    => _controller.onGameComplete(),
        );
      case PreviewType.abcLearn:
        return AbcLearnGame(
          onScore:      (pts) => _controller.addScore(pts),
          onSetMax:     (max) => _controller.setMaxScore(max),
          onGameOver:   ()    => _controller.onGameComplete(),
        );
      case PreviewType.spellIt:
        return SpellItGame(
          onScore:      (pts) => _controller.addScore(pts),
          onSetMax:     (max) => _controller.setMaxScore(max),
          onGameOver:   ()    => _controller.onGameComplete(),
        );

    }
  }

  @override
  Widget build(BuildContext context) {
    final r = GameShellResponsive(MediaQuery.of(context).size);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF7),
      body: AnimatedBuilder(
        animation: _controller.screenFadeController,
        builder: (_, child) => Opacity(
          opacity: _controller.screenFade.value,
          child: child,
        ),
        child: SafeArea(
          child: Stack(
            children: [

              // ── Main game layout ─────────────────
              Column(
                children: [

                  SizedBox(height: r.topBarHeight * 0.15),

                  // Top bar
                  ShellTopBar(
                    controller: _controller,
                    r:          r,
                    onPause:    _onPause,
                    onBack:     _onBack,
                    onSettings:  _onSettings,
                  ),

                  SizedBox(height: r.scoreBarHeight * 0.18),

                  // Score + timer
                  ShellScoreBar(
                    controller: _controller,
                    r:          r,
                  ),

                  SizedBox(height: r.timerBarMarginTop),

                  // Timer progress bar
                  ShellTimerBar(
                    controller: _controller,
                    r:          r,
                  ),

                  SizedBox(height: r.gameAreaTopGap),

                  // ── Game content area ────────────
                  Expanded(child: _buildGameContent()),

                  SizedBox(height: r.gameAreaBottomGap),
                ],
              ),

              // ── Pause overlay ─────────────────────
              ListenableBuilder(
                listenable: _controller,
                builder: (_, _) {
                  if (!_controller.isPaused) return const SizedBox.shrink();
                  return _Overlay(
                    child: ShellPauseDialog(
                      controller: _controller,
                      r:          r,
                      onResume:   _onResume,
                      onHome:     _onHome,
                    ),
                  );
                },
              ),

              // ── Result overlay ────────────────────
              ListenableBuilder(
                listenable: _controller,
                builder: (_, _) {
                  if (!_controller.isFinished) return const SizedBox.shrink();
                  return _Overlay(
                    child: ShellResultDialog(
                      controller: _controller,
                      r:          r,
                      onPlayAgain:_onPlayAgain,
                      onHome:     _onHome,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Dimmed overlay wrapper ─────────────────────
class _Overlay extends StatelessWidget {
  final Widget child;
  const _Overlay({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.45),
      child: Center(child: child),
    );
  }
}