import 'package:flutter/material.dart';
import '../age_selection_controller.dart';
import '../age_selection_responsive.dart';
 
// ════════════════════════════════════════════════
// AGE CARD
// ════════════════════════════════════════════════
class AgeCard extends StatelessWidget {
  final AgeGroupModel model;
  final int index;
  final AgeSelectionController controller;
  final AgeSelectionResponsive r;
  final VoidCallback onTap;
 
  const AgeCard({
    super.key,
    required this.model,
    required this.index,
    required this.controller,
    required this.r,
    required this.onTap,
  });
 
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.cardController(index),
      builder: (context, child) => Opacity(
        opacity: controller.cardFade(index).value,
        child: Transform.translate(
          offset: Offset(controller.cardSlide(index).value, 0),
          child: child,
        ),
      ),
      child: GestureDetector(
        onTapDown:   (_) => controller.onCardTapDown(index),
        onTapUp:     (_) => controller.onCardTapUp(index),
        onTapCancel: ()  => controller.onCardTapUp(index),
        onTap: onTap,
        child: ListenableBuilder(
          listenable: controller,
          builder: (context, _) => AnimatedScale(
            scale: controller.isTapped(index) ? 0.95 : 1.0,
            duration: const Duration(milliseconds: 120),
            child: _CardBody(model: model, r: r),
          ),
        ),
      ),
    );
  }
}
 
// ── Card body (pure UI, no logic) ──────────────
class _CardBody extends StatelessWidget {
  final AgeGroupModel model;
  final AgeSelectionResponsive r;
  const _CardBody({required this.model, required this.r});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: r.cardWidth,
      height: r.cardHeight,
      decoration: BoxDecoration(
        color: model.cardColor,
        borderRadius: BorderRadius.circular(r.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: model.shadowColor.withOpacity(0.45),
            blurRadius: r.cardShadowBlur,
            offset: Offset(0, r.cardShadowOffset),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: r.cardHorizontalPad),
      child: Row(
        children: [
 
          // Emoji
          Text(model.emoji, style: TextStyle(fontSize: r.cardEmojiSize)),
 
          SizedBox(width: r.cardHorizontalPad),
 
          // Labels
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              /*  Text(
                  '${model.ageLabel} Years',
                  style: TextStyle(
                    fontSize: r.cardTitleSize * 0.75,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),*/
                const SizedBox(height: 2),
                Text(
                  model.title,
                  style: TextStyle(
                    fontSize: r.cardTitleSize,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  model.subtitle,
                  style: TextStyle(
                    fontSize: r.cardSubtitleSize,
                    color: Colors.white.withOpacity(0.80),
                  ),
                ),
              ],
            ),
          ),
 
          // Arrow
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white.withOpacity(0.80),
            size: r.cardArrowSize,
          ),
        ],
      ),
    );
  }
}