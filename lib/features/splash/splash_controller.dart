import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends ChangeNotifier {

  // ── Controllers ────────────────────────────────
  late AnimationController mascotController;
  late AnimationController fadeController;
  late AnimationController starController;
  late AnimationController dotsController;

  // ── Animations ─────────────────────────────────
  late Animation<double> mascotBounce;
  late Animation<double> fadeIn;
  late Animation<double> titleSlide;

  // ──────────────────────────────────────────────
  // INIT
  // ──────────────────────────────────────────────
  void init(TickerProvider vsync) {
    _initMascotBounce(vsync);
    _initFadeIn(vsync);
    _initStarSpin(vsync);
    _initDots(vsync);
  }

  void _initMascotBounce(TickerProvider vsync) {
    mascotController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    mascotBounce = Tween<double>(begin: 0, end: -14).animate(
      CurvedAnimation(parent: mascotController, curve: Curves.easeInOut),
    );
  }

  void _initFadeIn(TickerProvider vsync) {
    fadeController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 900),
    )..forward();

    fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: fadeController, curve: Curves.easeIn),
    );

    titleSlide = Tween<double>(begin: 40, end: 0).animate(
      CurvedAnimation(parent: fadeController, curve: Curves.easeOutCubic),
    );
  }

  void _initStarSpin(TickerProvider vsync) {
    starController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  void _initDots(TickerProvider vsync) {
    dotsController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }


  Future<String?> getNavigationRoute() async {

  final results = await Future.wait([
    Future.delayed(const Duration(seconds: 5)),  
    _loadLastAgeGroup(),
      ]);

  // getLastAgeGroup result is in results[1]
  return results[1] as String?;
}

Future<String?> _loadLastAgeGroup() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('last_age_group');
}

  // ──────────────────────────────────────────────
  // DISPOSE
  // ──────────────────────────────────────────────
  void disposeAll() {
    mascotController.dispose();
    fadeController.dispose();
    starController.dispose();
    dotsController.dispose();
  }
}