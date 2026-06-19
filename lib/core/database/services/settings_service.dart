// lib/core/database/services/settings_service.dart

import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {

  // ─── KEYS (constants, never hardcode strings) ─────
  static const String _soundKey     = 'sound_enabled';
  static const String _musicKey     = 'music_enabled';
  static const String _lastAgeKey   = 'last_age_group';

  // ─── SOUND ────────────────────────────────────────

  Future<void> setSoundEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_soundKey, value);
  }

  Future<bool> isSoundEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_soundKey) ?? true;    // default ON
  }

  // ─── MUSIC ────────────────────────────────────────

  Future<void> setMusicEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_musicKey, value);
  }

  Future<bool> isMusicEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_musicKey) ?? true;    // default ON
  }

  // ─── LAST SELECTED AGE GROUP ──────────────────────

  Future<void> saveLastAgeGroup(String ageGroup) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastAgeKey, ageGroup);
  }

  Future<String?> getLastAgeGroup() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastAgeKey);        // null if first launch
  }

  // ─── RESET ALL SETTINGS ───────────────────────────

  Future<void> resetSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}