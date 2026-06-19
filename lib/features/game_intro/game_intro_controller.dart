import 'package:flutter/material.dart';
import '../../../core/database/services/star_service.dart';

// ── Game Config Model ──────────────────────────────
class GameConfig {
  final String ageGroup;
  final String ageLabel;
  final String gameId;
  final String gameName;
  final String gameSubtitle;
  final Color  primaryColor;
  final Color  darkColor;
  final Color  startTextColor;
  final PreviewType previewType;

  const GameConfig({
    required this.ageGroup,
    required this.ageLabel,
    required this.gameId,
    required this.gameName,
    required this.gameSubtitle,
    required this.primaryColor,
    required this.darkColor,
    required this.startTextColor,
    required this.previewType,
  });
}

// Each age has a different preview widget type
enum PreviewType { shapeMatch, abcLearn, spellIt }

class GameIntroController extends ChangeNotifier {

  // ── Services ───────────────────────────────────
  final StarService _starService = StarService();

  // ── State ──────────────────────────────────────
  late GameConfig config;
  int bestStars = 0;
  bool isStartPressed = false;

  // ── Game Configs per age ───────────────────────
  static const Map<String, GameConfig> gameConfigs = {
    'age_2_3': GameConfig(
      ageGroup:      'age_2_3',
      ageLabel:      '2 – 3 Years',
      gameId:        'shape_match',
      gameName:      'Shape Match!',
      gameSubtitle:  'Drag shapes to the right hole',
      primaryColor:  Color(0xFFFF8C69),
      darkColor:     Color(0xFFD45A30),
      startTextColor:Color(0xFFD45A30),
      previewType:   PreviewType.shapeMatch,
    ),
    'age_3_4': GameConfig(
      ageGroup:      'age_3_4',
      ageLabel:      '3 – 4 Years',
      gameId:        'abc_learn',
      gameName:      'ABC Learn!',
      gameSubtitle:  'Tap the correct letter',
      primaryColor:  Color(0xFF7C6FF7),
      darkColor:     Color(0xFF5A52D5),
      startTextColor:Color(0xFF5A52D5),
      previewType:   PreviewType.abcLearn,
    ),
    'age_5_6': GameConfig(
      ageGroup:      'age_5_6',
      ageLabel:      '5 – 6 Years',
      gameId:        'spell_it',
      gameName:      'Spell It!',
      gameSubtitle:  'Build words from letters',
      primaryColor:  Color(0xFF4ECBA1),
      darkColor:     Color(0xFF2EA87E),
      startTextColor:Color(0xFF2EA87E),
      previewType:   PreviewType.spellIt,
    ),
  };

  // ── Animation Controllers ──────────────────────
  late AnimationController masterFadeController;
  late AnimationController titleController;
  late AnimationController previewController;
  late AnimationController startBtnController;
  late AnimationController floatController;

  // ── Animations ─────────────────────────────────
  late Animation<double> masterFade;
  late Animation<double> titleSlide;
  late Animation<double> titleFade;
  late Animation<double> previewScale;
  late Animation<double> previewFade;
  late Animation<double> startBtnScale;
  late Animation<double> startBtnFade;
  late Animation<double> floatOffset;   // preview items floating up/down

  // ──────────────────────────────────────────────
  // INIT
  // ──────────────────────────────────────────────
  void init(TickerProvider vsync, String ageGroup) {
    config    = gameConfigs[ageGroup]!;
    bestStars = _starService.getStars(
      ageGroup: ageGroup,
      gameId: config.gameId,
    );
    _initAnimations(vsync);
    _startEntranceSequence();
  }

  void _initAnimations(TickerProvider vsync) {
    // Master fade — entire screen fades in
    masterFadeController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 400),
    );
    masterFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: masterFadeController, curve: Curves.easeIn),
    );

    // Title slides down from top
    titleController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 600),
    );
    titleSlide = Tween<double>(begin: -40, end: 0).animate(
      CurvedAnimation(parent: titleController, curve: Curves.easeOutCubic),
    );
    titleFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: titleController, curve: Curves.easeIn),
    );

    // Preview zone pops in with elastic
    previewController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 700),
    );
    previewScale = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(parent: previewController, curve: Curves.elasticOut),
    );
    previewFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: previewController, curve: Curves.easeIn),
    );

    // Start button bounces in
    startBtnController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 600),
    );
    startBtnScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: startBtnController, curve: Curves.elasticOut),
    );
    startBtnFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: startBtnController, curve: Curves.easeIn),
    );

    // Continuous float — preview items bob up and down
    floatController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    floatOffset = Tween<double>(begin: -6, end: 6).animate(
      CurvedAnimation(parent: floatController, curve: Curves.easeInOut),
    );
  }

  // Staggered entrance — feels alive
  Future<void> _startEntranceSequence() async {
    masterFadeController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    titleController.forward();
    await Future.delayed(const Duration(milliseconds: 250));
    previewController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    startBtnController.forward();
  }

  // ── Start button press ─────────────────────────
  void onStartPressed() {
    isStartPressed = true;
    notifyListeners();
  }

  // ── Refresh best stars when returning ─────────
  void refreshBestStars() {
    bestStars = _starService.getStars(
      ageGroup: config.ageGroup,
      gameId:   config.gameId,
    );
    notifyListeners();
  }

  // ── Stars label text ───────────────────────────
  String get bestStarsLabel => bestStars == 0
    ? 'Not played yet'
    : '$bestStars / 3 stars';

  // ──────────────────────────────────────────────
  // DISPOSE
  // ──────────────────────────────────────────────
  void disposeAll() {
    masterFadeController.dispose();
    titleController.dispose();
    previewController.dispose();
    startBtnController.dispose();
    floatController.dispose();
  }
}