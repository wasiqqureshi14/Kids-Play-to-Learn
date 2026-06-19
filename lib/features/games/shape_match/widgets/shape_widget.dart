import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/shape_match/shape_match_controller.dart';
import 'package:kids_learning/features/games/shape_match/shape_painter.dart';


class ShapeWidget extends StatelessWidget {
  final ShapeModel shape;
  final double     size;
  final double     labelSize;
  final double     labelGap;
  final bool       isDragging;

  const ShapeWidget({
    super.key,
    required this.shape,
    required this.size,
    required this.labelSize,
    required this.labelGap,
    required this.isDragging,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width:  size,
        height: size,
        decoration: BoxDecoration(
          color: shape.lightColor,
          borderRadius: BorderRadius.circular(size * 0.22),
          border: Border.all(
            color: shape.color.withOpacity(0.35),
            width: 2.5,
          ),
          boxShadow: isDragging
            ? [
                BoxShadow(
                  color:      shape.color.withOpacity(0.35),
                  blurRadius: 20,
                  spreadRadius: 4,
                ),
              ]
            : [],
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: EdgeInsets.all(size * 0.06),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize:      MainAxisSize.min,
              children: [

                // ✅ Custom painted shape — always correct!
                ShapeDisplay(
                  shape:    shape,
                  size:     size * 0.52,
                  isFilled: true,
                ),

                SizedBox(height: labelGap),

                Text(
                  shape.label,
                  style: TextStyle(
                    fontSize:   labelSize,
                    fontWeight: FontWeight.w800,
                    color:      shape.color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}