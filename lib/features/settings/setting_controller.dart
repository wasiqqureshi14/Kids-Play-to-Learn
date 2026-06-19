import 'package:flutter/material.dart';
import 'package:kids_learning/core/database/services/audio_services.dart';
import '../../core/database/services/settings_service.dart';
import '../../core/database/services/star_service.dart';

class SettingsController extends ChangeNotifier {

  final SettingsService _settings = SettingsService();
  final StarService     _stars    = StarService();
  final AudioService    _audio    = AudioService();

  bool soundEnabled = true;
  bool musicEnabled = true;
  bool isResetting  = false;

  // ── INIT ──────────────────────────────────────
  Future<void> init() async {
    soundEnabled = await _settings.isSoundEnabled();
    musicEnabled = await _settings.isMusicEnabled();
    notifyListeners();
  }

  // ── SOUND TOGGLE ──────────────────────────────
  Future<void> toggleSound(bool value) async {
    soundEnabled = value;
    notifyListeners();
    await _audio.toggleSound(value);
  }

  // ── MUSIC TOGGLE ──────────────────────────────
  Future<void> toggleMusic(bool value) async {
    musicEnabled = value;
    notifyListeners();
    await _audio.toggleMusic(value);
  }

  // ── RESET PROGRESS ────────────────────────────
  Future<void> resetProgress(BuildContext context) async {
    // Show confirm dialog first
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Reset Progress?',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        content: const Text(
          'All your stars and progress will be deleted. This cannot be undone!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Reset',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    isResetting = true;
    notifyListeners();

    await _stars.resetAll();

    isResetting = false;
    notifyListeners();
  }
}