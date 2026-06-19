import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kids_learning/core/database/services/audio_services.dart';
import 'package:kids_learning/features/age_selection/age_selection_screen.dart';
import 'package:kids_learning/features/game_intro/game_intro_controller.dart';
import 'package:kids_learning/features/game_intro/game_intro_screen.dart';
import 'package:kids_learning/features/games/shared/game_shell_screen.dart';
import 'package:kids_learning/features/settings/setting_screen.dart';
import 'package:kids_learning/features/splash/splash_screen.dart';
import 'core/database/hive_manager.dart';

void main() async {

 WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // ✅ Make app fullscreen (hide status & navigation bar)
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // ✅ Initialize Hive Database
  await HiveManager.init();


  runApp(const MyApp());

  await AudioService().init();

  AudioService().playBackgroundMusic();   
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ─── App Info ───────────────────────────────
      title: 'Kids Learning Game',
      debugShowCheckedModeBanner: false,

      // ─── Theme ──────────────────────────────────
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B6B),
          brightness: Brightness.light,
        ),
        useMaterial3: true,

        fontFamily: 'Fredoka',

        // Disable ugly splash effect on buttons for kids UI
        splashFactory: NoSplash.splashFactory,
      ),

      // ─── Entry Point ────────────────────────────
    home: const SplashScreen(),
routes: {
  '/age-select': (_) => const AgeSelectionScreen(),
  '/game-intro': (ctx) {
    final age = ModalRoute.of(ctx)!.settings.arguments as String;
    return GameIntroScreen(ageGroup: age);
  },  
  '/settings':     (_) => const SettingScreen(),
}, 
onGenerateRoute: (settings) {
        if (settings.name == '/game') {
          final config = settings.arguments as GameConfig;
          return MaterialPageRoute(
            builder: (_) => GameShellScreen(config: config),
          );
        }
        return null;
      },
    );
  }
}


