import 'package:flutter/material.dart';
import 'package:kids_learning/core/database/services/audio_services.dart';
import 'package:kids_learning/features/age_selection/widgets/age_selection_card.dart';
import 'age_selection_controller.dart';
import 'age_selection_responsive.dart';
import 'widgets/age_selection_background.dart';
import 'widgets/age_selection_header.dart';

class AgeSelectionScreen extends StatefulWidget {
  const AgeSelectionScreen({super.key});

  @override
  State<AgeSelectionScreen> createState() => _AgeSelectionScreenState();
}

class _AgeSelectionScreenState extends State<AgeSelectionScreen>
    with TickerProviderStateMixin {
  final _controller = AgeSelectionController();

  @override
  void initState() {
    super.initState();
    _controller.init(this);

      AudioService().playMenuMusic();
  }

  @override
  void dispose() {
    _controller.disposeAll();
    super.dispose();
  }

  // ── On age card tapped ─────────────────────────
  Future<void> _onAgeTapped(AgeGroupModel model) async {
    await _controller.saveAgeSelection(model.key);
    if (!mounted) return;
    Navigator.pushReplacementNamed(
      context,
      '/game-intro',
      arguments: model.key,
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = AgeSelectionResponsive(MediaQuery.of(context).size);

    return Scaffold(
      body: Stack(
        children: [

          // ── Background ──────────────────────────
          AgeSelectionBackground(r: r),

          // ── Scrollable content ──────────────────
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // ← FIX: center everything
                  children: [
                
                    SizedBox(height: r.headerTopPadding),
                
                    // Header
                    AgeSelectionHeader(controller: _controller, r: r),
                
                    SizedBox(height: r.headerBottomGap),
                
                    // Age Cards
                    ...List.generate(
                      AgeSelectionController.ageGroups.length,
                      (index) {
                        final model = AgeSelectionController.ageGroups[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: r.cardSpacing),
                          child: AgeCard(
                            model:      model,
                            index:      index,
                            controller: _controller,
                            r:          r,
                            onTap:      () => _onAgeTapped(model),
                          ),
                        );
                      },
                    ),
                
                    SizedBox(height: r.bottomGrassHeight * 1.5),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}