import 'package:flutter/material.dart';
import 'package:kids_learning/core/database/services/star_service.dart';
import 'package:kids_learning/features/game_intro/game_intro_controller.dart';

class GameResult {
  final int score;
  final int maxScore;
  final int stars;
  final bool isNewBest;

  const GameResult({
    required this.score,
    required this.maxScore,
    required this.isNewBest,
    required this.stars
  });

  double get percentage => maxScore ==0?0 : score/maxScore ;

}
enum GameState {playing, pause, finished, paused}

class GameShellController extends ChangeNotifier{

  final StarService _starService = StarService();

  late GameConfig config;

  GameState gameState = GameState.playing;
  int currentScore = 0;
  int maxScore = 100;
  int timeLeft = 60;
  bool timerRunning = false;
  GameResult? result;

  late AnimationController screenFadeController;
  late AnimationController scorePopController;
  late AnimationController timerColorController;
  late AnimationController dialogController;

  late Animation<double> screenFade ;
  late Animation<double> scorePop;
  late Animation<double> dialogScale;
  late Animation<double> dialogFade;

   late AnimationController _timerTickController;

   void init(TickerProvider vsync, GameConfig gameConfig){
    config = gameConfig;
    _initAnimations(vsync);
    _startScreenEntrance();
   }

   void _initAnimations(TickerProvider vsync){
    screenFadeController = AnimationController(vsync: vsync, 
    duration: const Duration(milliseconds: 400)
    );
    screenFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: screenFadeController, curve: Curves.easeIn)
    );

    scorePopController = AnimationController(vsync: vsync,
    duration: const Duration(milliseconds: 400));
    scorePop = Tween<double>(begin: 1.0, end: 1.35).animate(
      CurvedAnimation(parent: scorePopController, curve: Curves.elasticOut));

      timerColorController = AnimationController(vsync: vsync,
      duration: const Duration(milliseconds: 500));

      dialogController = AnimationController(vsync: vsync,
      duration: Duration(milliseconds: 600));
      dialogScale = Tween<double>(begin: 0.6, end: 1.0).animate(
        CurvedAnimation(parent: dialogController, curve: Curves.elasticOut)
      );
      dialogFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: dialogController, curve: Curves.easeIn)
      );

       _timerTickController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 1),
    );
    _timerTickController.addStatusListener(_onTimerTick);
   }

    void startTimer() {
    timerRunning = true;
    _timerTickController.forward(from: 0);
  }

  void _onTimerTick(AnimationStatus status) {
    if (status == AnimationStatus.completed && timerRunning) {
      timeLeft--;
      notifyListeners();

      // Shake timer color red when under 10 secs
      if (timeLeft <= 10) {
        timerColorController.forward(from: 0);
      }

      if (timeLeft <= 0) {
        _onTimeUp();
      } else {
        _timerTickController.forward(from: 0);
      }
    }
  }

  void pauseTimer() {
    timerRunning = false;
    _timerTickController.stop();
  }

  void resumeTimer() {
    timerRunning = true;
    _timerTickController.forward(from: 0);
  }

  // ──────────────────────────────────────────────
  // SCORE
  // ──────────────────────────────────────────────

  // Called by each game when player scores
  void addScore(int points) {
    currentScore += points;
    if (currentScore > maxScore) currentScore = maxScore;
    notifyListeners();
    _popScore();
  }

  // Called by game to set max possible score
  void setMaxScore(int max) {
    maxScore = max;
  }

  void _popScore() {
    scorePopController.forward(from: 0);
  }

  // ──────────────────────────────────────────────
  // GAME STATE
  // ──────────────────────────────────────────────
  void pauseGame() {
    if (gameState != GameState.playing) return;
    gameState = GameState.paused;
    pauseTimer();
    notifyListeners();
  }

  void resumeGame() {
    if (gameState != GameState.paused) return;
    gameState = GameState.playing;
    resumeTimer();
    notifyListeners();
  }

  void _onTimeUp() {
    timerRunning = false;
    _finishGame();
  }

  // Called by game when all rounds complete
  void onGameComplete() {
    timerRunning = false;
    _timerTickController.stop();
    _finishGame();
  }

  void _finishGame() {
    gameState = GameState.finished;

    // Calculate stars
    final percentage = maxScore == 0 ? 0.0 : currentScore / maxScore;
    final stars = _calculateStars(percentage);

    // Check if new best
    final previousBest = _starService.getStars(
      ageGroup: config.ageGroup,
      gameId:   config.gameId,
    );
    final isNewBest = stars > previousBest;

    // Save to Hive
    _starService.saveStars(
      ageGroup: config.ageGroup,
      gameId:   config.gameId,
      stars:    stars,
    );

    result = GameResult(
      score:      currentScore,
      maxScore:   maxScore,
      stars:      stars,
      isNewBest:  isNewBest,
    );

    notifyListeners();

    // Show result dialog with slight delay for feel
    Future.delayed(const Duration(milliseconds: 300), () {
      dialogController.forward();
    });
  }

  int _calculateStars(double percentage) {
    if (percentage >= 0.70) return 3;
    if (percentage >= 0.40) return 2;
    if (percentage >  0.0)  return 1;
    return 0;
  }

  // ──────────────────────────────────────────────
  // GETTERS
  // ──────────────────────────────────────────────

  // 0.0 → 1.0 for timer progress bar
  double get timerProgress => timeLeft / 60;

  // Timer bar color — green → orange → red
  Color timerBarColor(Color primaryColor) {
    if (timeLeft > 30) return primaryColor;
    if (timeLeft > 10) return const Color(0xFFFFB347);
    return const Color(0xFFFF4444);
  }

  // Score as formatted text
  String get scoreText => '$currentScore';
  String get maxScoreText => '$maxScore';

  // Timer text — always 2 digits
  String get timerText {
    final mins = (timeLeft ~/ 60).toString().padLeft(2, '0');
    final secs = (timeLeft  % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  bool get isPlaying  => gameState == GameState.playing;
  bool get isPaused   => gameState == GameState.paused;
  bool get isFinished => gameState == GameState.finished;

  // ──────────────────────────────────────────────
  // ENTRANCE
  // ──────────────────────────────────────────────
  Future<void> _startScreenEntrance() async {
    await screenFadeController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    startTimer();
  }

  // ──────────────────────────────────────────────
  // DISPOSE
  // ──────────────────────────────────────────────
  void disposeAll() {
    screenFadeController.dispose();
    scorePopController.dispose();
    timerColorController.dispose();
    dialogController.dispose();
    _timerTickController.dispose();
  }

}