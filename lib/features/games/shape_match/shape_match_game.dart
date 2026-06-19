
import 'package:flutter/material.dart';
import 'package:kids_learning/features/games/shape_match/widgets/drop_zone.dart';
import 'package:kids_learning/features/games/shape_match/widgets/progress_dots.dart';
import 'package:kids_learning/features/games/shape_match/widgets/round_indicator.dart';
import 'shape_match_controller.dart';
import 'shape_match_responsive.dart';


class ShapeMatchGame extends StatefulWidget {
  final Function(int) onScore;
  final Function(int) onSetMax;
  final VoidCallback  onGameOver;

  const ShapeMatchGame({
    super.key,
    required this.onScore,
    required this.onSetMax,
    required this.onGameOver,
  });

  @override
  State<ShapeMatchGame> createState() => _ShapeMatchGameState();
}

class _ShapeMatchGameState extends State<ShapeMatchGame>
    with TickerProviderStateMixin {

  final _controller = ShapeMatchController();

  @override
  void initState() {
    super.initState();
    _controller.init(
      vsync:      this,
      onScore:    widget.onScore,
      onSetMax:   widget.onSetMax,
      onGameOver: widget.onGameOver,
    );
  }

  @override
  void dispose() {
    _controller.disposeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = ShapeMatchResponsive(MediaQuery.of(context).size);

    return ListenableBuilder(
      listenable: _controller,
      builder: (_, _) => Column(
        children: [

          // Round indicator
          ShapeRoundIndicator(controller: _controller, r: r),

          SizedBox(height: r.roundTopGap),

          // Progress dots
          ShapeProgressDots(controller: _controller, r: r),

          SizedBox(height: r.dotAreaTopGap),

          // Draggable shape + feedback
          DraggableShapeArea(controller: _controller, r: r),

          const Spacer(),

          // Drop zones row
          ShapeDropZonesRow(controller: _controller, r: r),

          const Spacer(),
        ],
      ),
    );
  }
}