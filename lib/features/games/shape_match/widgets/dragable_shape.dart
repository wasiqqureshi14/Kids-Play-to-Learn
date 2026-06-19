import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/shape_match/shape_match_controller.dart';
import 'package:kids_learning/features/games/shape_match/shape_match_responsive.dart';
import 'package:kids_learning/features/games/shape_match/widgets/shape_widget.dart';

class DraggableShape extends StatelessWidget {
  final ShapeMatchController controller;
  final ShapeMatchResponsive r;

  const DraggableShape({
    super.key,
    required this.controller,
    required this.r,
  });

  @override
  Widget build(BuildContext context) {
    final shape = controller.currentRound.dragShape;

    return AnimatedBuilder(
      animation: controller.shapeSlideController,
      builder: (_, child) => Opacity(
        opacity: controller.shapeSlideFade.value,
        child: Transform.translate(
          offset: Offset(controller.shapeSlideIn.value, 0),
          child:  child,
        ),
      ),
      child: AnimatedBuilder(
        animation: controller.dragShakeController,
        builder: (_, child) => Transform.translate(
          offset: Offset(controller.dragShake.value, 0),
          child:  child,
        ),
        child: Draggable<String>(
          data: shape.id,

          // What shows while dragging (follows finger)
          feedback: ShapeWidget(
            shape:      shape,
            size:       r.shapeSize,
            labelSize:  r.shapeLabelSize,
            labelGap:   r.shapeLabelGap,
            isDragging: true,
          ),

          // What stays in place (ghost)
          childWhenDragging: Opacity(
            opacity: 0.35,
            child: ShapeWidget(
              shape:      shape,
              size:       r.shapeSize,
              labelSize:  r.shapeLabelSize,
              labelGap:   r.shapeLabelGap,
              isDragging: false,
            ),
          ),

          // Normal state
          child: ShapeWidget(
            shape:      shape,
            size:       r.shapeSize,
            labelSize:  r.shapeLabelSize,
            labelGap:   r.shapeLabelGap,
            isDragging: false,
          ),
        ),
      ),
    );
  }
}