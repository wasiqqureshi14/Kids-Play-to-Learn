import 'package:flutter/material.dart';
import 'package:kids_learning/core/database/services/audio_services.dart';

// ── Word Model ─────────────────────────────────────
class WordModel {
  final String word;
  final String emoji;
  final String hint;
  final Color  color;
  final Color  lightColor;

  const WordModel({
    required this.word,
    required this.emoji,
    required this.hint,
    required this.color,
    required this.lightColor,
  });
}

// ── Tapped Letter ──────────────────────────────────
class TappedLetter {
  final String letter;
  final int    choiceIndex;

  const TappedLetter({
    required this.letter,
    required this.choiceIndex,
  });
}

// ── Answer Box State ───────────────────────────────
enum BoxState { empty, filled, correct, wrong }

// ── Choice Button State ────────────────────────────
enum ChoiceState { normal, used }

class SpellItController extends ChangeNotifier {

  // ── Word bank ──────────────────────────────────
  static const List<WordModel> allWords = [
    WordModel(
      word: 'CAT', emoji: '🐱', hint: 'What animal is this?',
      color: Color(0xFF4ECBA1), lightColor: Color(0xFFE0F5EE),
    ),
    WordModel(
      word: 'DOG', emoji: '🐶', hint: 'What animal is this?',
      color: Color(0xFF4A90E2), lightColor: Color(0xFFD6EAFF),
    ),
    WordModel(
      word: 'SUN', emoji: '☀️', hint: 'What is in the sky?',
      color: Color(0xFFF5A623), lightColor: Color(0xFFFFF0D6),
    ),
    WordModel(
      word: 'BUS', emoji: '🚌', hint: 'What vehicle is this?',
      color: Color(0xFFFF8C69), lightColor: Color(0xFFFFEDE8),
    ),
    WordModel(
      word: 'HEN', emoji: '🐔', hint: 'What bird is this?',
      color: Color(0xFFE25555), lightColor: Color(0xFFFFD6D6),
    ),
    WordModel(
      word: 'FROG', emoji: '🐸', hint: 'What animal is this?',
      color: Color(0xFF7CB342), lightColor: Color(0xFFEAF3DE),
    ),
    WordModel(
      word: 'BIRD', emoji: '🐦', hint: 'What animal is this?',
      color: Color(0xFF26C6DA), lightColor: Color(0xFFE0F7FA),
    ),
    WordModel(
      word: 'FISH', emoji: '🐟', hint: 'What animal is this?',
      color: Color(0xFF4A90E2), lightColor: Color(0xFFD6EAFF),
    ),
    WordModel(
      word: 'BEAR', emoji: '🐻', hint: 'What animal is this?',
      color: Color(0xFF8D6E63), lightColor: Color(0xFFEFEBE9),
    ),
    WordModel(
      word: 'DUCK', emoji: '🦆', hint: 'What bird is this?',
      color: Color(0xFFF5A623), lightColor: Color(0xFFFFF0D6),
    ),
  ];

  // ── Game state ─────────────────────────────────
  List<WordModel> rounds        = [];
  int             currentIndex  = 0;
  List<TappedLetter> tapped     = [];
  List<String>    shuffledChoices = [];
  List<BoxState>  boxStates     = [];
  List<ChoiceState> choiceStates = [];
  bool            isAdvancing   = false;
  bool            isWrongFlash  = false;

  // ── Callbacks ──────────────────────────────────
  late Function(int) onScore;
  late Function(int) onSetMax;
  late VoidCallback  onGameOver;

  // ── Animation Controllers ──────────────────────
  late AnimationController emojiEntranceController;
  late AnimationController answerEntranceController;
  late AnimationController choicesEntranceController;
  late AnimationController wrongShakeController;
  late AnimationController correctScaleController;

  // ── Animations ─────────────────────────────────
  late Animation<double> emojiScale;
  late Animation<double> emojiFade;
  late Animation<double> answerSlide;
  late Animation<double> answerFade;
  late Animation<double> choicesSlide;
  late Animation<double> choicesFade;
  late Animation<double> wrongShake;
  late Animation<double> correctScale;

  // ──────────────────────────────────────────────
  // INIT
  // ──────────────────────────────────────────────
  void init({
    required TickerProvider vsync,
    required Function(int) onScore,
    required Function(int) onSetMax,
    required VoidCallback  onGameOver,
  }) {
    this.onScore    = onScore;
    this.onSetMax   = onSetMax;
    this.onGameOver = onGameOver;

    _generateRounds();
    onSetMax(rounds.length * 10);
    _initAnimations(vsync);
    _setupRound();
    _playEntrance();
  }

  // ──────────────────────────────────────────────
  // ROUND SETUP
  // ──────────────────────────────────────────────
  void _generateRounds() {
    rounds = List<WordModel>.from(allWords)..shuffle();
    rounds = rounds.take(10).toList();
  }

  void _setupRound() {
    final word = rounds[currentIndex].word;

    // Reset state
    tapped        = [];
    boxStates     = List.filled(word.length, BoxState.empty);
    isWrongFlash  = false;

    // Build shuffled choices — correct letters + 2-3 wrong letters
    final wordLetters  = word.split('');
    final extraLetters = _pickExtraLetters(wordLetters);
    shuffledChoices    = [...wordLetters, ...extraLetters]..shuffle();
    choiceStates       = List.filled(shuffledChoices.length, ChoiceState.normal);

    notifyListeners();
  }

  // Pick letters NOT in the word
  List<String> _pickExtraLetters(List<String> wordLetters) {
    const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final extras   = alphabet.split('')
      ..removeWhere((l) => wordLetters.contains(l))
      ..shuffle();

    // 3-letter words get 3 extras, 4-letter words get 2 extras
    final count = wordLetters.length <= 3 ? 3 : 2;
    return extras.take(count).toList();
  }

  // ──────────────────────────────────────────────
  // ANIMATIONS INIT
  // ──────────────────────────────────────────────
  void _initAnimations(TickerProvider vsync) {

    // Emoji bounces in
    emojiEntranceController = AnimationController(
      vsync:    vsync,
      duration: const Duration(milliseconds: 550),
    );
    emojiScale = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: emojiEntranceController,
        curve:  Curves.elasticOut,
      ),
    );
    emojiFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: emojiEntranceController,
        curve:  Curves.easeIn,
      ),
    );

    // Answer boxes slide up
    answerEntranceController = AnimationController(
      vsync:    vsync,
      duration: const Duration(milliseconds: 450),
    );
    answerSlide = Tween<double>(begin: 40, end: 0).animate(
      CurvedAnimation(
        parent: answerEntranceController,
        curve:  Curves.easeOutCubic,
      ),
    );
    answerFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: answerEntranceController,
        curve:  Curves.easeIn,
      ),
    );

    // Choices slide up from bottom
    choicesEntranceController = AnimationController(
      vsync:    vsync,
      duration: const Duration(milliseconds: 450),
    );
    choicesSlide = Tween<double>(begin: 60, end: 0).animate(
      CurvedAnimation(
        parent: choicesEntranceController,
        curve:  Curves.easeOutCubic,
      ),
    );
    choicesFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: choicesEntranceController,
        curve:  Curves.easeIn,
      ),
    );

    // Wrong answer — shake boxes
    wrongShakeController = AnimationController(
      vsync:    vsync,
      duration: const Duration(milliseconds: 450),
    );
    wrongShake = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0,   end: -10), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10, end: 10),  weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10,  end: -8),  weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8,  end: 8),   weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8,   end: 0),   weight: 1),
    ]).animate(CurvedAnimation(
      parent: wrongShakeController,
      curve:  Curves.easeInOut,
    ));

    // Correct — boxes pop scale
    correctScaleController = AnimationController(
      vsync:    vsync,
      duration: const Duration(milliseconds: 400),
    );
    correctScale = Tween<double>(begin: 1.0, end: 1.12).animate(
      CurvedAnimation(
        parent: correctScaleController,
        curve:  Curves.elasticOut,
      ),
    );
  }

  // Staggered entrance per round
  Future<void> _playEntrance() async {
    emojiEntranceController.reset();
    answerEntranceController.reset();
    choicesEntranceController.reset();

    emojiEntranceController.forward();
    await Future.delayed(const Duration(milliseconds: 180));
    answerEntranceController.forward();
    await Future.delayed(const Duration(milliseconds: 150));
    choicesEntranceController.forward();
  }

  // ──────────────────────────────────────────────
  // GAME LOGIC
  // ──────────────────────────────────────────────
  WordModel get currentWord  => rounds[currentIndex];
  int       get totalRounds  => rounds.length;
  bool      get isLastRound  => currentIndex >= rounds.length - 1;

  // Called when a choice letter is tapped
  Future<void> onChoiceTapped(int choiceIndex) async {
    if (isAdvancing) return;
    if (choiceStates[choiceIndex] == ChoiceState.used) return;
    if (tapped.length >= currentWord.word.length) return;

    final letter    = shuffledChoices[choiceIndex];
    final boxIndex  = tapped.length;

    // Mark choice as used
    choiceStates[choiceIndex] = ChoiceState.used;

    // Fill next box
    tapped.add(TappedLetter(letter: letter, choiceIndex: choiceIndex));
    boxStates[boxIndex] = BoxState.filled;
    notifyListeners();

    // Check if word is complete
    if (tapped.length == currentWord.word.length) {
      await _checkWord();
    }
  }

  Future<void> _checkWord() async {
    final formed = tapped.map((t) => t.letter).join('');
    final target = currentWord.word;

    if (formed == target) {
      await _onCorrect();
    } else {
      await _onWrong();
    }
  }

  Future<void> _onCorrect() async {
    isAdvancing = true;

    // All boxes → correct state
    boxStates = List.filled(currentWord.word.length, BoxState.correct);
    notifyListeners();
    AudioService().playCorrect();

    // Pop animation
    correctScaleController.forward(from: 0);
    onScore(10);

    await Future.delayed(const Duration(milliseconds: 800));

    if (isLastRound) {
      onGameOver();
    } else {
      currentIndex++;
      isAdvancing = false;
      _setupRound();
      await _playEntrance();
    }
  }

  Future<void> _onWrong() async {
    // All boxes → wrong state
    isWrongFlash = true;
    boxStates    = List.filled(currentWord.word.length, BoxState.wrong);
    notifyListeners();
    AudioService().playWrong();

    // Shake animation
    wrongShakeController.forward(from: 0);

    await Future.delayed(const Duration(milliseconds: 700));

    // Auto clear
    clearAnswer();
  }

  // Clear all tapped letters
  void clearAnswer() {
    tapped        = [];
    boxStates     = List.filled(currentWord.word.length, BoxState.empty);
    choiceStates  = List.filled(shuffledChoices.length, ChoiceState.normal);
    isWrongFlash  = false;
    wrongShakeController.reset();
    notifyListeners();
  }

  // ──────────────────────────────────────────────
  // DISPOSE
  // ──────────────────────────────────────────────
  void disposeAll() {
    emojiEntranceController.dispose();
    answerEntranceController.dispose();
    choicesEntranceController.dispose();
    wrongShakeController.dispose();
    correctScaleController.dispose();
  }
}