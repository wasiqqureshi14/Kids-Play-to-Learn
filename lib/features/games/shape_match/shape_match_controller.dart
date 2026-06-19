import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kids_learning/core/database/services/audio_services.dart';


enum ShapeType {
  square,
  circle,
  diamond,
  triangle,
  star,
  rectangle,
  pentagon,
  heart,
  oval,
  hexagon,
}
// ── Shape Model ────────────────────────────────────
class ShapeModel {
  final String id;
  final ShapeType shapeType;
  final String label;
  final Color  color;
  final Color  lightColor;

  const ShapeModel({
    required this.id,
    required this.shapeType,
    required this.label,
    required this.color,
    required this.lightColor,
  });
}

// ── Round Model ────────────────────────────────────
class ShapeRound {
  final ShapeModel dragShape;      // shape to drag
  final List<ShapeModel> zones;    // 3 drop zones
  final int correctZoneIndex;      // which zone is correct

  const ShapeRound({
    required this.dragShape,
    required this.zones,
    required this.correctZoneIndex,
  });
}

// ── Drop Feedback ──────────────────────────────────
enum DropFeedback { none, correct, wrong }

class ShapeMatchController extends ChangeNotifier {

 static const List<ShapeModel> allShapes = [
  ShapeModel(
    id:         'square',
    label:      'Square',
    shapeType:  ShapeType.square,
    color:      Color(0xFF4A90E2),
    lightColor: Color(0xFFD6EAFF),
  ),
  ShapeModel(
    id:         'circle',
    label:      'Circle',
    shapeType:  ShapeType.circle,
    color:      Color(0xFFE25555),
    lightColor: Color(0xFFFFD6D6),
  ),
  ShapeModel(
    id:         'diamond',
    label:      'Diamond',
    shapeType:  ShapeType.diamond,
    color:      Color(0xFF4ECBA1),
    lightColor: Color(0xFFD6F5EC),
  ),
  ShapeModel(
    id:         'triangle',
    label:      'Triangle',
    shapeType:  ShapeType.triangle,
    color:      Color(0xFF9B6FF7),
    lightColor: Color(0xFFEDE0FF),
  ),
  ShapeModel(
    id:         'star',
    label:      'Star',
    shapeType:  ShapeType.star,
    color:      Color(0xFFF5A623),
    lightColor: Color(0xFFFFF0D6),
  ),
  ShapeModel(
    id:         'rectangle',
    label:      'Rectangle',
    shapeType:  ShapeType.rectangle,
    color:      Color(0xFFFF8C69),
    lightColor: Color(0xFFFFEDE8),
  ),
  ShapeModel(
    id:         'pentagon',
    label:      'Pentagon',
    shapeType:  ShapeType.pentagon,
    color:      Color(0xFF26C6DA),
    lightColor: Color(0xFFE0F7FA),
  ),
  ShapeModel(
    id:         'heart',
    label:      'Heart',
    shapeType:  ShapeType.heart,
    color:      Color(0xFFEC407A),
    lightColor: Color(0xFFFCE4EC),
  ),
  ShapeModel(
    id:         'oval',
    label:      'Oval',
    shapeType:  ShapeType.oval,
    color:      Color(0xFF7CB342),
    lightColor: Color(0xFFEAF3DE),
  ),
  ShapeModel(
    id:         'hexagon',
    label:      'Hexagon',
    shapeType:  ShapeType.hexagon,
    color:      Color(0xFF8D6E63),
    lightColor: Color(0xFFEFEBE9),
  ),
];

  // ── Game State ─────────────────────────────────
  List<ShapeRound> rounds     = [];
  int currentRoundIndex       = 0;
  DropFeedback feedback       = DropFeedback.none;
  bool isAdvancing            = false;   // prevents double tap
  int  wrongAttempts          = 0;       // per round

  // ── Callbacks to Shell ─────────────────────────
  late Function(int) onScore;
  late Function(int) onSetMax;
  late VoidCallback  onGameOver;

  // ── Animation Controllers ──────────────────────
  late AnimationController dragShakeController;
  late AnimationController shapeSlideController;
  late AnimationController feedbackController;
  late AnimationController dropZoneController;

  // ── Animations ─────────────────────────────────
  late Animation<double> dragShake;
  late Animation<double> shapeSlideIn;
  late Animation<double> shapeSlideFade;
  late Animation<double> feedbackScale;
  late Animation<double> dropZonePulse;

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
    onSetMax(rounds.length * 10);   // tell shell max score
    _initAnimations(vsync);
    _slideInCurrentShape();
  }

  // ──────────────────────────────────────────────
  // ROUND GENERATION
  // ──────────────────────────────────────────────
  void _generateRounds() {
    rounds = [];
    final shuffled = List<ShapeModel>.from(allShapes)..shuffle();

    // 10 rounds — cycle through shapes twice
    final shapePool = [...shuffled, ...shuffled];

    for (int i = 0; i < 10; i++) {
      final dragShape = shapePool[i];

      // Pick 2 wrong shapes — different from correct
      final wrongShapes = List<ShapeModel>.from(allShapes)
        ..removeWhere((s) => s.id == dragShape.id)
        ..shuffle();

      final zone0 = wrongShapes[0];
      final zone1 = wrongShapes[1];
      final correctIndex = Random().nextInt(3);   // random correct position

      // Build 3 zones with correct one at correctIndex
      final zones = <ShapeModel>[];
      int wrongIdx = 0;
      for (int z = 0; z < 3; z++) {
        if (z == correctIndex) {
          zones.add(dragShape);
        } else {
          zones.add(wrongIdx == 0 ? zone0 : zone1);
          wrongIdx++;
        }
      }

      rounds.add(ShapeRound(
        dragShape:         dragShape,
        zones:             zones,
        correctZoneIndex:  correctIndex,
      ));
    }
  }

  // ──────────────────────────────────────────────
  // ANIMATIONS INIT
  // ──────────────────────────────────────────────
  void _initAnimations(TickerProvider vsync) {

    // Wrong drop — shake left/right
    dragShakeController = AnimationController(
      vsync:    vsync,
      duration: const Duration(milliseconds: 500),
    );
    dragShake = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -12), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -12, end: 12), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 12, end: -8),  weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8, end: 8),   weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8, end: 0),    weight: 1),
    ]).animate(CurvedAnimation(
      parent: dragShakeController,
      curve:  Curves.easeInOut,
    ));

    // New shape slides in from right
    shapeSlideController = AnimationController(
      vsync:    vsync,
      duration: const Duration(milliseconds: 450),
    );
    shapeSlideIn = Tween<double>(begin: 120, end: 0).animate(
      CurvedAnimation(parent: shapeSlideController, curve: Curves.easeOutCubic),
    );
    shapeSlideFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: shapeSlideController, curve: Curves.easeIn),
    );

    // Correct/wrong feedback icon pops
    feedbackController = AnimationController(
      vsync:    vsync,
      duration: const Duration(milliseconds: 400),
    );
    feedbackScale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: feedbackController, curve: Curves.elasticOut),
    );

    // Drop zone pulses when shape is hovering over it
    dropZoneController = AnimationController(
      vsync:    vsync,
      duration: const Duration(milliseconds: 300),
    )..repeat(reverse: true);
    dropZonePulse = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: dropZoneController, curve: Curves.easeInOut),
    );
  }

  // ──────────────────────────────────────────────
  // GAME LOGIC
  // ──────────────────────────────────────────────

  ShapeRound get currentRound => rounds[currentRoundIndex];
  bool get isLastRound => currentRoundIndex >= rounds.length - 1;
  int  get totalRounds => rounds.length;

  // Called when shape is dropped on a zone
  Future<void> onDrop(int zoneIndex) async {
    if (isAdvancing) return;
    if (feedback != DropFeedback.none) return;

    final isCorrect = zoneIndex == currentRound.correctZoneIndex;

    if (isCorrect) {
      await _onCorrectDrop();
    } else {
      await _onWrongDrop();
    }
  }

  Future<void> _onCorrectDrop() async {
    isAdvancing = true;
    feedback    = DropFeedback.correct;
    notifyListeners();

    AudioService().playCorrect();
    feedbackController.forward(from: 0);
    onScore(10);

    await Future.delayed(const Duration(milliseconds: 700));

    // Advance to next round
    if (isLastRound) {
      onGameOver();
    } else {
      currentRoundIndex++;
      wrongAttempts = 0;
      feedback      = DropFeedback.none;
      isAdvancing   = false;
      notifyListeners();
      _slideInCurrentShape();
    }
  }

  Future<void> _onWrongDrop() async {
    feedback      = DropFeedback.wrong;
    wrongAttempts++;
    notifyListeners();

    // Shake the shape
    AudioService().playWrong();
    dragShakeController.forward(from: 0);

    await Future.delayed(const Duration(milliseconds: 600));

    feedback = DropFeedback.none;
    notifyListeners();
  }

  void _slideInCurrentShape() {
    shapeSlideController.forward(from: 0);
  }

  // ──────────────────────────────────────────────
  // DRAGGING STATE
  // ──────────────────────────────────────────────
  int? hoveredZoneIndex;    // which zone is being hovered

  void onDragHover(int? zoneIndex) {
    if (hoveredZoneIndex == zoneIndex) return;
    hoveredZoneIndex = zoneIndex;
    notifyListeners();
  }

  // ──────────────────────────────────────────────
  // DISPOSE
  // ──────────────────────────────────────────────
  void disposeAll() {
    dragShakeController.dispose();
    shapeSlideController.dispose();
    feedbackController.dispose();
    dropZoneController.dispose();
  }
}