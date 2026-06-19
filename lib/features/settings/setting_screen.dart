import 'package:flutter/material.dart';
import 'package:kids_learning/features/settings/setting_controller.dart';
import 'package:kids_learning/features/settings/widgets/reset_button.dart';
import 'package:kids_learning/features/settings/widgets/setting_topbar.dart';
import 'package:kids_learning/features/settings/widgets/title_section.dart';
import 'package:kids_learning/features/settings/widgets/toggle_section.dart';
import 'settings_responsive.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingScreen> {

  final _controller = SettingsController();

  @override
  void initState() {
    super.initState();
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    final r = SettingsResponsive(MediaQuery.of(context).size);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F5),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _controller,
          builder: (_, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Top bar
              SettingsTopBar(
                r:      r,
                onBack: () => Navigator.pop(context),
              ),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: r.sectionTopGap),

                      // ── Audio section ──────────
                      SettingsSectionTitle(title: 'AUDIO', r: r),

                      SizedBox(height: r.sectionTopGap * 0.5),

                      SettingsToggleTile(
                        title:    'Sound Effects',
                        subtitle: 'Correct & wrong answer sounds',
                        emoji:    '🔊',
                        color:    const Color(0xFF7C6FF7),
                        value:    _controller.soundEnabled,
                        onChanged:(val) => _controller.toggleSound(val),
                        r:        r,
                      ),

                      SettingsToggleTile(
                        title:    'Background Music',
                        subtitle: 'Adventure music while playing',
                        emoji:    '🎵',
                        color:    const Color(0xFF4ECBA1),
                        value:    _controller.musicEnabled,
                        onChanged:(val) => _controller.toggleMusic(val),
                        r:        r,
                      ),

                      SizedBox(height: r.sectionTopGap),

                      // ── Progress section ───────
                      SettingsSectionTitle(title: 'PROGRESS', r: r),

                      SizedBox(height: r.sectionTopGap * 0.5),

                      SettingsResetButton(
                        controller: _controller,
                        r:          r,
                        onTap: () => _controller.resetProgress(context),
                      ),

                      SizedBox(height: r.sectionTopGap * 2),

                      // ── Version ────────────────
                      Center(child: SettingsVersion(r: r)),

                      SizedBox(height: r.versionBottomGap),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}