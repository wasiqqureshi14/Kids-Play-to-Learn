import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kids_learning/core/database/services/audio_services.dart';

// ── Letter Model ───────────────────────────────────
class LetterModel {
  final String letter;
  final String emoji;
  final String word;
  final Color  color;

  const LetterModel({
    required this.letter,
    required this.emoji,
    required this.word,
    required this.color,
  });
}

// ── Round Model ────────────────────────────────────
class AbcRound {
  final LetterModel correct;
  final List<LetterModel> choices;  // 3 choices including correct
  final int correctIndex;

  const AbcRound({
    required this.correct,
    required this.choices,
    required this.correctIndex,
  });
}

// ── Choice state ───────────────────────────────────
enum ChoiceState { normal, correct, wrong }

class AbcLearnController extends ChangeNotifier {

  // ── All letters ────────────────────────────────
  static const List<LetterModel> allLetters = [
    LetterModel(letter: 'A', emoji: '🍎', word: 'Apple',
      color: Color(0xFFE25555)),
    LetterModel(letter: 'B', emoji: '🦋', word: 'Butterfly',
      color: Color(0xFF4A90E2)),
    LetterModel(letter: 'C', emoji: '🐱', word: 'Cat',
      color: Color(0xFFFF8C69)),
    LetterModel(letter: 'D', emoji: '🐶', word: 'Dog',
      color: Color(0xFF9B6FF7)),
    LetterModel(letter: 'E', emoji: '🐘', word: 'Elephant',
      color: Color(0xFF4ECBA1)),
    LetterModel(letter: 'F', emoji: '🐸', word: 'Frog',
      color: Color(0xFF7CB342)),
    LetterModel(letter: 'G', emoji: '🦒', word: 'Giraffe',
      color: Color(0xFFF5A623)),
    LetterModel(letter: 'H', emoji: '🐴', word: 'Horse',
      color: Color(0xFF8D6E63)),
    LetterModel(letter: 'I', emoji: '🍦', word: 'Ice Cream',
      color: Color(0xFFEC407A)),
    LetterModel(letter: 'J', emoji: '🦘', word: 'Jumper',
      color: Color(0xFF26C6DA)),
    LetterModel(letter: 'K', emoji: '🦘', word: 'Kangaroo',
      color: Color(0xFFFF7043)),
    LetterModel(letter: 'L', emoji: '🦁', word: 'Lion',
      color: Color(0xFFF5A623)),
    LetterModel(letter: 'M', emoji: '🐒', word: 'Monkey',
      color: Color(0xFF8D6E63)),
    LetterModel(letter: 'N', emoji: '🌙', word: 'Night',
      color: Color(0xFF5C6BC0)),
    LetterModel(letter: 'O', emoji: '🐙', word: 'Octopus',
      color: Color(0xFFE25555)),
    LetterModel(letter: 'P', emoji: '🐧', word: 'Penguin',
      color: Color(0xFF4A90E2)),
    LetterModel(letter: 'Q', emoji: '👸', word: 'Queen',
      color: Color(0xFF9B6FF7)),
    LetterModel(letter: 'R', emoji: '🌈', word: 'Rainbow',
      color: Color(0xFFFF8C69)),
    LetterModel(letter: 'S', emoji: '🌟', word: 'Star',
      color: Color(0xFFF5A623)),
    LetterModel(letter: 'T', emoji: '🐯', word: 'Tiger',
      color: Color(0xFFFF7043)),
    LetterModel(letter: 'U', emoji: '☂️', word: 'Umbrella',
      color: Color(0xFF26C6DA)),
    LetterModel(letter: 'V', emoji: '🎻', word: 'Violin',
      color: Color(0xFF7CB342)),
    LetterModel(letter: 'W', emoji: '🐳', word: 'Whale',
      color: Color(0xFF4A90E2)),
    LetterModel(letter: 'X', emoji: '🎸', word: 'Xylophone',
      color: Color(0xFF9B6FF7)),
    LetterModel(letter: 'Y', emoji: '🪀', word: 'Yo-yo',
      color: Color(0xFFEC407A)),
    LetterModel(letter: 'Z', emoji: '🦓', word: 'Zebra',
      color: Color(0xFF5C6BC0)),
  ];

  // ── Game state ─────────────────────────────────
  List<AbcRound>  rounds          = [];
  int             currentIndex    = 0;
  bool            isAdvancing     = false;

  // ── Per-choice state ───────────────────────────
  List<ChoiceState> choiceStates  = [
    ChoiceState.normal,
    ChoiceState.normal,
    ChoiceState.normal,
  ];

  // ── Callbacks to shell ─────────────────────────
  late Function(int) onScore;
  late Function(int) onSetMax;
  late VoidCallback  onGameOver;

  // ── Animation Controllers ──────────────────────
  late AnimationController letterEntranceController;
  late AnimationController emojiEntranceController;
  late AnimationController choicesEntranceController;
  late AnimationController wrongShakeController;
  late AnimationController correctScaleController;

  // ── Animations ─────────────────────────────────
  late Animation<double> letterScale;
  late Animation<double> letterFade;
  late Animation<double> emojiSlide;
  late Animation<double> emojiFade;
  late Animation<double> choicesSlide;
  late Animation<double> choicesFade;
  late Animation<double> wrongShake;
  late Animation<double> correctScale;

  // ── Which choice is shaking ────────────────────
  int? shakingIndex;

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
    _playRoundEntrance();
  }

  // ──────────────────────────────────────────────
  // ROUND GENERATION
  // ──────────────────────────────────────────────
  void _generateRounds() {
    final shuffled = List<LetterModel>.from(allLetters)..shuffle();
    final selected = shuffled.take(10).toList();

    rounds = selected.map((correct) {
      // Pick 2 wrong letters
      final wrong = List<LetterModel>.from(allLetters)
        ..removeWhere((l) => l.letter == correct.letter)
        ..shuffle();

      final choice0 = wrong[0];
      final choice1 = wrong[1];
      final correctIdx = Random().nextInt(3);
      final choices = <LetterModel>[];
      int wrongPtr = 0;
      for (int i = 0; i < 3; i++) {
        if (i == correctIdx) {
          choices.add(correct);
        } else {
          choices.add(wrongPtr == 0 ? choice0 : choice1);
          wrongPtr++;
        }
      }

      return AbcRound(
        correct:      correct,
        choices:      choices,
        correctIndex: correctIdx,
      );
    }).toList();
  }

  // ──────────────────────────────────────────────
  // ANIMATIONS
  // ──────────────────────────────────────────────
  void _initAnimations(TickerProvider vsync) {

    // Big letter scales in
    letterEntranceController = AnimationController(
      vsync:    vsync,
      duration: const Duration(milliseconds: 500),
    );
    letterScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: letterEntranceController,
        curve:  Curves.elasticOut,
      ),
    );
    letterFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: letterEntranceController,
        curve:  Curves.easeIn,
      ),
    );

    // Emoji slides up
    emojiEntranceController = AnimationController(
      vsync:    vsync,
      duration: const Duration(milliseconds: 450),
    );
    emojiSlide = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(
        parent: emojiEntranceController,
        curve:  Curves.easeOutCubic,
      ),
    );
    emojiFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: emojiEntranceController,
        curve:  Curves.easeIn,
      ),
    );

    // Choices slide up from bottom
    choicesEntranceController = AnimationController(
      vsync:    vsync,
      duration: const Duration(milliseconds: 450),
    );
    choicesSlide = Tween<double>(begin: 50, end: 0).animate(
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

    // Wrong answer shake
    wrongShakeController = AnimationController(
      vsync:    vsync,
      duration: const Duration(milliseconds: 400),
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

    // Correct answer scale pop
    correctScaleController = AnimationController(
      vsync:    vsync,
      duration: const Duration(milliseconds: 350),
    );
    correctScale = Tween<double>(begin: 1.0, end: 1.18).animate(
      CurvedAnimation(
        parent: correctScaleController,
        curve:  Curves.elasticOut,
      ),
    );
  }

  // Staggered entrance per round
  Future<void> _playRoundEntrance() async {
    // Reset all
    letterEntranceController.reset();
    emojiEntranceController.reset();
    choicesEntranceController.reset();

    _resetChoiceStates();

    // Play staggered
    letterEntranceController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    emojiEntranceController.forward();
    await Future.delayed(const Duration(milliseconds: 150));
    choicesEntranceController.forward();
  }

  void _resetChoiceStates() {
    choiceStates = [
      ChoiceState.normal,
      ChoiceState.normal,
      ChoiceState.normal,
    ];
    shakingIndex = null;
    notifyListeners();
  }

  // ──────────────────────────────────────────────
  // GAME LOGIC
  // ──────────────────────────────────────────────
  AbcRound get currentRound  => rounds[currentIndex];
  int      get totalRounds   => rounds.length;
  bool     get isLastRound   => currentIndex >= rounds.length - 1;

  Future<void> onChoiceTapped(int choiceIndex) async {
    if (isAdvancing) return;

    final isCorrect = choiceIndex == currentRound.correctIndex;

    if (isCorrect) {
      await _onCorrect(choiceIndex);
    } else {
      await _onWrong(choiceIndex);
    }
  }

  Future<void> _onCorrect(int index) async {
    isAdvancing = true;

    // Mark correct
    choiceStates[index] = ChoiceState.correct;
    notifyListeners();
    AudioService().playCorrect();

    // Pop animation
    correctScaleController.forward(from: 0);
    onScore(10);

    await Future.delayed(const Duration(milliseconds: 700));

    if (isLastRound) {
      onGameOver();
    } else {
      currentIndex++;
      isAdvancing = false;
      await _playRoundEntrance();
    }
  }

  Future<void> _onWrong(int index) async {
    // Mark wrong + shake
    choiceStates[index] = ChoiceState.wrong;
    shakingIndex = index;
    notifyListeners();
    AudioService().playWrong();

    wrongShakeController.forward(from: 0);
    await Future.delayed(const Duration(milliseconds: 500));

    // Reset that choice back to red (stay red, no shake)
    shakingIndex = null;
    notifyListeners();
  }

  // ──────────────────────────────────────────────
  // DISPOSE
  // ──────────────────────────────────────────────
  void disposeAll() {
    letterEntranceController.dispose();
    emojiEntranceController.dispose();
    choicesEntranceController.dispose();
    wrongShakeController.dispose();
    correctScaleController.dispose();
  }
}