import 'package:just_audio/just_audio.dart';
import 'package:kids_learning/core/database/services/settings_service.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  // ── One music player, one sfx player ──────────
  final AudioPlayer _musicPlayer = AudioPlayer();
  final AudioPlayer _sfxPlayer   = AudioPlayer();

  final SettingsService _settings = SettingsService();

  bool _musicEnabled  = true;
  bool _soundEnabled  = true;
  bool _initialized   = false;
  bool _isGameMusic   = false;  // tracks which music is current

  // ──────────────────────────────────────────────
  // INIT
  // ──────────────────────────────────────────────
  Future<void> init() async {
    if (_initialized) return;
    try {
      _musicEnabled = await _settings.isMusicEnabled();
      _soundEnabled = await _settings.isSoundEnabled();

      await _musicPlayer.setVolume(0.35);
      await _musicPlayer.setLoopMode(LoopMode.one);

      await _sfxPlayer.setVolume(1.0);

      // ✅ After SFX finishes → restore music volume
      _sfxPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          _musicPlayer.setVolume(_musicEnabled ? 0.35 : 0);
        }
      });

      _initialized = true;
      print('✅ AudioService initialized');
    } catch (e) {
      print('❌ Init failed: $e');
    }
  }

  // ──────────────────────────────────────────────
  // MENU MUSIC
  // ──────────────────────────────────────────────
  Future<void> playMenuMusic() async {
    if (!_musicEnabled) return;
    try {
      _isGameMusic = false;
      await _musicPlayer.setAsset('assets/audio/happy_for_kid.mp3');
      await _musicPlayer.setLoopMode(LoopMode.one);
      await _musicPlayer.setVolume(0.35);
      await _musicPlayer.play();
      print('🎵 Menu music playing');
    } catch (e) {
      print('❌ Menu music failed: $e');
    }
  }

  // ──────────────────────────────────────────────
  // GAME MUSIC
  // ──────────────────────────────────────────────
  Future<void> playGameMusic() async {
    if (!_musicEnabled) return;
    try {
      _isGameMusic = true;
      await _musicPlayer.setAsset('assets/audio/game_music.mp3');
      await _musicPlayer.setLoopMode(LoopMode.one);
      await _musicPlayer.setVolume(0.35);
      await _musicPlayer.play();
      print('🎮 Game music playing');
    } catch (e) {
      print('❌ Game music failed: $e');
    }
  }

  Future<void> stopGameMusic() async {
    try {
      await _musicPlayer.stop();
    } catch (e) {}
  }

  Future<void> pauseGameMusic() async {
    try {
      await _musicPlayer.pause();
    } catch (e) {}
  }

  Future<void> resumeGameMusic() async {
    if (!_musicEnabled) return;
    try {
      await _musicPlayer.play();
    } catch (e) {}
  }

  // ──────────────────────────────────────────────
  // SOUND EFFECTS
  // ✅ Duck music → play SFX → auto restore
  // ──────────────────────────────────────────────
  Future<void> playCorrect() async {
    if (!_soundEnabled) return;
    try {
      // Duck music to 10%
      await _musicPlayer.setVolume(0.10);

      // Play correct sound
      await _sfxPlayer.setAsset('assets/audio/correct-answer-sound.mp3');
      await _sfxPlayer.seek(Duration.zero);
      await _sfxPlayer.play();

      print('✅ Correct buzz');
    } catch (e) {
      print('❌ Correct failed: $e');
      // Safety — restore music even if SFX fails
      await _musicPlayer.setVolume(0.35);
    }
  }

  Future<void> playWrong() async {
    if (!_soundEnabled) return;
    try {
      // Duck music to 10%
      await _musicPlayer.setVolume(0.10);

      // Play wrong sound
      await _sfxPlayer.setAsset('assets/audio/wrong-answer.mp3');
      await _sfxPlayer.seek(Duration.zero);
      await _sfxPlayer.play();

      print('❌ Wrong buzz');
    } catch (e) {
      print('❌ Wrong failed: $e');
      // Safety — restore music even if SFX fails
      await _musicPlayer.setVolume(0.35);
    }
  }

  // ──────────────────────────────────────────────
  // SETTINGS TOGGLES
  // ──────────────────────────────────────────────
  Future<void> toggleMusic(bool enabled) async {
    _musicEnabled = enabled;
    await _settings.setMusicEnabled(enabled);
    if (enabled) {
      await _musicPlayer.setVolume(0.35);
      await _musicPlayer.play();
    } else {
      await _musicPlayer.pause();
    }
  }

  Future<void> toggleSound(bool enabled) async {
    _soundEnabled = enabled;
    await _settings.setSoundEnabled(enabled);
  }

  bool get isMusicEnabled => _musicEnabled;
  bool get isSoundEnabled => _soundEnabled;
}