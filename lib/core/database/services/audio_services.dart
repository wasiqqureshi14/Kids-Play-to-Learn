
import 'package:audioplayers/audioplayers.dart';
import 'package:kids_learning/core/database/services/settings_service.dart';

class AudioService {

  // Singleton — one instance across whole app
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _musicPlayer = AudioPlayer();
  final AudioPlayer _sfxPlayer   = AudioPlayer();
  final SettingsService _settings = SettingsService();

  bool _musicEnabled = true;
  bool _soundEnabled = true;
  bool _initialized = false;

  // ── INIT — call once at app start ─────────────
  Future<void> init() async {
    _musicEnabled = await _settings.isMusicEnabled();
    _soundEnabled = await _settings.isSoundEnabled();

    // Loop background music
   try {
      await _musicPlayer.setReleaseMode(ReleaseMode.loop);
      await _musicPlayer.setVolume(0.45);
      _initialized = true;

      await _sfxPlayer.setReleaseMode(ReleaseMode.stop);
      await _sfxPlayer.setVolume(1.0);
      await _sfxPlayer.setPlayerMode(PlayerMode.lowLatency); 
    } catch (e) {
      // ✅ Never crash app if audio setup fails
      print('Audio init failed: $e');
    }
  }

  // ── BACKGROUND MUSIC ──────────────────────────
  Future<void> playBackgroundMusic() async {
    if (!_musicEnabled) return;
   try {
      await _musicPlayer.play(AssetSource('audio/happy_for_kid.mp3'));
    } catch (e) {
      // ✅ Just log it — never throw, never block UI
      print('Music play failed: $e');
    }
  
  }

   Future<void> pauseMusic() async {
    try {
      await _musicPlayer.pause();
    } catch (e) {
      print('Music pause failed: $e');
    }
  }

  Future<void> resumeMusic() async {
    if (!_musicEnabled) return;
   try {
      await _musicPlayer.resume();
    } catch (e) {
      print('Music resume failed: $e');
    }
  
  }

  Future<void> stopMusic() async {
    await _musicPlayer.stop();
  }

  // ── SOUND EFFECTS ─────────────────────────────
  Future<void> playCorrect() async {
    if (!_soundEnabled) return;
    await _sfxPlayer.play(AssetSource('audio/correct-answer-sound.mp3'));
  }

  Future<void> playWrong() async {
    if (!_soundEnabled) return;
    await _sfxPlayer.play(AssetSource('audio/wrong-answer.mp3'));
  }

  Future<void> playButtonTap() async {
    if (!_soundEnabled) return;
    await _sfxPlayer.play(AssetSource('audio/tap.mp3'));
  }

  // ── TOGGLE ────────────────────────────────────
  Future<void> toggleMusic(bool enabled) async {
    _musicEnabled = enabled;
    await _settings.setMusicEnabled(enabled);
    if (enabled) {
      await resumeMusic();
    } else {
      await pauseMusic();
    }
  }

  Future<void> toggleSound(bool enabled) async {
    _soundEnabled = enabled;
    await _settings.setSoundEnabled(enabled);
  }

  // ── GETTERS ───────────────────────────────────
  bool get isMusicEnabled => _musicEnabled;
  bool get isSoundEnabled => _soundEnabled;

  // ── DISPOSE ───────────────────────────────────
  Future<void> dispose() async {
    await _musicPlayer.dispose();
    await _sfxPlayer.dispose();
  }
}