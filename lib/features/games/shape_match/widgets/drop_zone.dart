import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/shape_match/shape_match_controller.dart';
import 'package:kids_learning/features/games/shape_match/shape_match_responsive.dart';
import 'package:kids_learning/features/games/shape_match/shape_painter.dart';
import 'package:kids_learning/features/games/shape_match/widgets/dragable_shape.dart';

class DraggableShapeArea extends StatelessWidget {
  final ShapeMatchController controller;
  final ShapeMatchResponsive r;

  const DraggableShapeArea({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: r.dragAreaHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [

          // ── Feedback icon ──────────────────────
          if (controller.feedback != DropFeedback.none)
            ShapeDropFeedback(controller: controller, r: r),

          // ── Draggable shape ────────────────────
          if (controller.feedback != DropFeedback.correct)
            DraggableShape(controller: controller, r: r),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════
// SINGLE DROP ZONE
// ════════════════════════════════════════════════
class ShapeDropZone extends StatelessWidget {
  final ShapeModel           shape;
  final int                  zoneIndex;
  final ShapeMatchController controller;
  final ShapeMatchResponsive r;

  const ShapeDropZone({
    super.key,
    required this.shape,
    required this.zoneIndex,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final isHovered = controller.hoveredZoneIndex == zoneIndex;

    return DragTarget<String>(
      onWillAcceptWithDetails: (_) {
        controller.onDragHover(zoneIndex);
        return true;
      },
      onLeave:              (_) => controller.onDragHover(null),
      onAcceptWithDetails:  (_) {
        controller.onDragHover(null);
        controller.onDrop(zoneIndex);
      },
      builder: (_, candidateData, _) {
        final hovering = candidateData.isNotEmpty || isHovered;

        return AnimatedBuilder(
          animation: controller.dropZoneController,
          builder: (_, child) => Transform.scale(
            scale: hovering ? controller.dropZonePulse.value : 1.0,
            child: child,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width:  r.dropZoneSize,
            height: r.dropZoneSize,
            decoration: BoxDecoration(
              color: hovering
                ? shape.lightColor
                : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(r.dropZoneRadius),
              border: Border.all(
                color: hovering
                  ? shape.color
                  : const Color(0xFFDDDDDD),
                width: r.dropZoneBorderWidth,
              ),
              boxShadow: hovering
                ? [
                    BoxShadow(
                      color:      shape.color.withOpacity(0.25),
                      blurRadius: 14,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
            ),
           child: FittedBox(
  fit: BoxFit.scaleDown,
  child: Padding(
    padding: EdgeInsets.all(r.dropZoneSize * 0.08),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize:      MainAxisSize.min,
      children: [

        // ✅ Outline shape for drop zone
        ShapeDisplay(
          shape:    shape,
          size:     r.dropZoneSize * 0.48,
          isFilled: false,   // ← outline only for drop zones
        ),

        SizedBox(height: r.dropZoneLabelGap),

        Text(
          shape.label,
          style: TextStyle(
            fontSize:   r.dropZoneLabelSize,
            fontWeight: FontWeight.w800,
            color: hovering
              ? shape.color
              : const Color(0xFFAAAAAA),
          ),
        ),
      ],
    ),
  ),
),
          ),
        );
      },
    );
  }
}

// ════════════════════════════════════════════════
// DROP ZONES ROW  (all 3 zones together)
// ════════════════════════════════════════════════
class ShapeDropZonesRow extends StatelessWidget {
  final ShapeMatchController controller;
  final ShapeMatchResponsive r;

  const ShapeDropZonesRow({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final zones = controller.currentRound.zones;

    return SizedBox(
      height: r.dropZoneAreaHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (i) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: r.dropZoneSpacing),
            child: ShapeDropZone(
              shape:      zones[i],
              zoneIndex:  i,
              controller: controller,
              r:          r,
            ),
          );
        }),
      ),
    );
  }
}

// ════════════════════════════════════════════════
// FEEDBACK ICON  (✅ or ❌ after drop)
// ════════════════════════════════════════════════
class ShapeDropFeedback extends StatelessWidget {
  final ShapeMatchController controller;
  final ShapeMatchResponsive r;

  const ShapeDropFeedback({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.feedbackController,
      builder: (_, _) => Transform.scale(
        scale: controller.feedbackScale.value,
        child: Text(
          controller.feedback == DropFeedback.correct ? '✅' : '❌',
          style: TextStyle(fontSize: r.feedbackIconSize),
        ),
      ),
    );
  }
}