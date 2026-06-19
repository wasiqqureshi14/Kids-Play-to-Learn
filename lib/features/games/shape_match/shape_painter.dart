import 'dart:math';
import 'package:flutter/material.dart';
import 'shape_match_controller.dart';

class ShapePainter extends CustomPainter {
  final ShapeType shapeType;
  final Color     color;
  final bool      isFilled;

  ShapePainter({
    required this.shapeType,
    required this.color,
    required this.isFilled,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color       = isFilled ? color : color.withOpacity(0.65)
      ..style       = isFilled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = isFilled ? 0 : 3.0;

    final cx = size.width  * 0.5;
    final cy = size.height * 0.5;
    final r  = min(cx, cy) * 0.75;

    switch (shapeType) {
      case ShapeType.square:
        _drawSquare(canvas, paint, cx, cy, r);
        break;
      case ShapeType.circle:
        _drawCircle(canvas, paint, cx, cy, r);
        break;
      case ShapeType.diamond:
        _drawDiamond(canvas, paint, cx, cy, r);
        break;
      case ShapeType.triangle:
        _drawTriangle(canvas, paint, cx, cy, r);
        break;
      case ShapeType.star:
        _drawStar(canvas, paint, cx, cy, r);
        break;
      case ShapeType.rectangle:
        _drawRectangle(canvas, paint, cx, cy, r);
        break;
      case ShapeType.pentagon:
        _drawPolygon(canvas, paint, cx, cy, r, 5, -pi / 2);
        break;
      case ShapeType.heart:
        _drawHeart(canvas, paint, cx, cy, r);
        break;
      case ShapeType.oval:
        _drawOval(canvas, paint, cx, cy, r);
        break;
      case ShapeType.hexagon:
        _drawPolygon(canvas, paint, cx, cy, r, 6, 0);
        break;
    }
  }

  // ── Square ─────────────────────────────────────
  void _drawSquare(Canvas c, Paint p, double cx, double cy, double r) {
    c.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, cy), width: r * 1.8, height: r * 1.8),
        const Radius.circular(10),
      ),
      p,
    );
  }

  // ── Circle ─────────────────────────────────────
  void _drawCircle(Canvas c, Paint p, double cx, double cy, double r) {
    c.drawCircle(Offset(cx, cy), r, p);
  }

  // ── Diamond ────────────────────────────────────
  void _drawDiamond(Canvas c, Paint p, double cx, double cy, double r) {
    final path = Path()
      ..moveTo(cx,         cy - r)        // top
      ..lineTo(cx + r,     cy)            // right
      ..lineTo(cx,         cy + r)        // bottom
      ..lineTo(cx - r,     cy)            // left
      ..close();
    c.drawPath(path, p);
  }

  // ── Triangle ───────────────────────────────────
  void _drawTriangle(Canvas c, Paint p, double cx, double cy, double r) {
    final path = Path()
      ..moveTo(cx,             cy - r)           // top
      ..lineTo(cx + r * 1.1,  cy + r * 0.8)     // bottom right
      ..lineTo(cx - r * 1.1,  cy + r * 0.8)     // bottom left
      ..close();
    c.drawPath(path, p);
  }

  // ── Star ───────────────────────────────────────
  void _drawStar(Canvas c, Paint p, double cx, double cy, double r) {
    final path    = Path();
    const points  = 5;
    final outerR  = r;
    final innerR  = r * 0.45;
    final angle   = -pi / 2;

    for (int i = 0; i < points * 2; i++) {
      final currR = i.isEven ? outerR : innerR;
      final a     = angle + (i * pi / points);
      final x     = cx + currR * cos(a);
      final y     = cy + currR * sin(a);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    c.drawPath(path, p);
  }

  // ── Rectangle ──────────────────────────────────
  void _drawRectangle(Canvas c, Paint p, double cx, double cy, double r) {
    c.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, cy), width: r * 2.2, height: r * 1.3),
        const Radius.circular(8),
      ),
      p,
    );
  }

  // ── Regular Polygon (pentagon, hexagon) ────────
  void _drawPolygon(
    Canvas c, Paint p, double cx, double cy,
    double r, int sides, double startAngle,
  ) {
    final path  = Path();
    final angle = (2 * pi) / sides;

    for (int i = 0; i < sides; i++) {
      final x = cx + r * cos(startAngle + i * angle);
      final y = cy + r * sin(startAngle + i * angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    c.drawPath(path, p);
  }

  // ── Heart ──────────────────────────────────────
  void _drawHeart(Canvas c, Paint p, double cx, double cy, double r) {
    final path = Path();
    final s    = r * 0.055;

    path.moveTo(cx, cy + r * 0.6);

    // Left curve
    path.cubicTo(
      cx - r * 1.2, cy,
      cx - r * 1.2, cy - r * 0.8,
      cx,           cy - r * 0.2,
    );

    // Right curve
    path.cubicTo(
      cx + r * 1.2, cy - r * 0.8,
      cx + r * 1.2, cy,
      cx,           cy + r * 0.6,
    );

    path.close();
    c.drawPath(path, p);
  }

  // ── Oval ───────────────────────────────────────
  void _drawOval(Canvas c, Paint p, double cx, double cy, double r) {
    c.drawOval(
      Rect.fromCenter(
        center: Offset(cx, cy),
        width:  r * 2.2,
        height: r * 1.4,
      ),
      p,
    );
  }

  @override
  bool shouldRepaint(ShapePainter old) =>
    old.shapeType != shapeType ||
    old.color     != color     ||
    old.isFilled  != isFilled;
}


// ════════════════════════════════════════════════
// SHAPE DISPLAY WIDGET — uses CustomPainter
// ════════════════════════════════════════════════
class ShapeDisplay extends StatelessWidget {
  final ShapeModel shape;
  final double     size;
  final bool       isFilled;

  const ShapeDisplay({
    super.key,
    required this.shape,
    required this.size,
    required this.isFilled,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:  size,
      height: size,
      child: CustomPaint(
        painter: ShapePainter(
          shapeType: shape.shapeType,
          color:     shape.color,
          isFilled:  isFilled,
        ),
      ),
    );
  }
}