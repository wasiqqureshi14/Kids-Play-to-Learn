import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ── Age Group Model ────────────────────────────────
class AgeGroupModel {
  final String key;
 // final String ageLabel;
  final String title;
  final String subtitle;
  final String emoji;
  final Color  cardColor;
  final Color  shadowColor;

  const AgeGroupModel({
    required this.key,
   // required this.ageLabel,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.cardColor,
    required this.shadowColor,
  });
}

class AgeSelectionController extends ChangeNotifier {

  // ── Age Groups Data ────────────────────────────
  static const List<AgeGroupModel> ageGroups = [
    AgeGroupModel(
      key:         'age_2_3',
     // ageLabel:    '2 - 3',
      title:       'Little Explorer',
      subtitle:    'Shape Match',
      emoji:       '🐣',
      cardColor:   Color(0xFFFF8C69),
      shadowColor: Color(0xFFFF6B40),
    ),
    AgeGroupModel(
      key:         'age_3_4',
     // ageLabel:    '3 - 4',
      title:       'Super Learner',
      subtitle:    'ABC Learn',
      emoji:       '🦁',
      cardColor:   Color(0xFF7C6FF7),
      shadowColor: Color(0xFF5A52D5),
    ),
    AgeGroupModel(
      key:         'age_5_6',
      //ageLabel:    '5 - 6',
      title:       'Bright Star',
      subtitle:    'Spell It',
      emoji:       '🚀',
      cardColor:   Color(0xFF4ECBA1),
      shadowColor: Color(0xFF2EA87E),
    ),
  ];

  // ── Animation Controllers ──────────────────────
  late AnimationController headerController;
  late AnimationController card1Controller;
  late AnimationController card2Controller;
  late AnimationController card3Controller;

  // ── Animations ─────────────────────────────────
  late Animation<double> headerFade;
  late Animation<double> headerSlide;
  late Animation<double> card1Slide;
  late Animation<double> card2Slide;
  late Animation<double> card3Slide;
  late Animation<double> card1Fade;
  late Animation<double> card2Fade;
  late Animation<double> card3Fade;

  // ── Tap scale state ────────────────────────────
  final List<bool> _tappedStates = [false, false, false];
  bool isTapped(int index) => _tappedStates[index];

  // ──────────────────────────────────────────────
  // INIT
  // ──────────────────────────────────────────────
  void init(TickerProvider vsync) {
    _initHeader(vsync);
    _initCards(vsync);
    _startEntranceSequence();
  }

  void _initHeader(TickerProvider vsync) {
    headerController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 700),
    );

    headerFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: headerController, curve: Curves.easeIn),
    );

    headerSlide = Tween<double>(begin: -30, end: 0).animate(
      CurvedAnimation(parent: headerController, curve: Curves.easeOutCubic),
    );
  }

  void _initCards(TickerProvider vsync) {
    // Each card has its own controller for staggered entrance
    final controllers = List.generate(3, (_) => AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 600),
    ));

    card1Controller = controllers[0];
    card2Controller = controllers[1];
    card3Controller = controllers[2];

    // Cards slide in from RIGHT side
    card1Slide = _cardSlide(card1Controller);
    card2Slide = _cardSlide(card2Controller);
    card3Slide = _cardSlide(card3Controller);

    card1Fade  = _cardFade(card1Controller);
    card2Fade  = _cardFade(card2Controller);
    card3Fade  = _cardFade(card3Controller);
  }

  Animation<double> _cardSlide(AnimationController c) =>
    Tween<double>(begin: 120, end: 0).animate(
      CurvedAnimation(parent: c, curve: Curves.easeOutCubic),
    );

  Animation<double> _cardFade(AnimationController c) =>
    Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: c, curve: Curves.easeIn),
    );

  // Staggered entrance — header first, then cards one by one
  Future<void> _startEntranceSequence() async {
    await headerController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    await card1Controller.forward();
    await Future.delayed(const Duration(milliseconds: 120));
    await card2Controller.forward();
    await Future.delayed(const Duration(milliseconds: 120));
    await card3Controller.forward();
  }

  // ──────────────────────────────────────────────
  // TAP LOGIC
  // ──────────────────────────────────────────────
  void onCardTapDown(int index) {
    _tappedStates[index] = true;
    notifyListeners();
  }

  void onCardTapUp(int index) {
    _tappedStates[index] = false;
    notifyListeners();
  }

  // Save selection & return route
  Future<void> saveAgeSelection(String ageKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_age_group', ageKey);
  }

  // Get animation by card index
  Animation<double> cardSlide(int index) =>
    [card1Slide, card2Slide, card3Slide][index];

  Animation<double> cardFade(int index) =>
    [card1Fade, card2Fade, card3Fade][index];

  AnimationController cardController(int index) =>
    [card1Controller, card2Controller, card3Controller][index];

  // ──────────────────────────────────────────────
  // DISPOSE
  // ──────────────────────────────────────────────
  void disposeAll() {
    headerController.dispose();
    card1Controller.dispose();
    card2Controller.dispose();
    card3Controller.dispose();
  }
}