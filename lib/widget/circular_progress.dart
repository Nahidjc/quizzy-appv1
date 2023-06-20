import 'dart:math';

import 'package:flutter/material.dart';

class CircleProgressBar extends StatefulWidget {
  final int timeRemaining;
  final double strokeWidth;
  final double radius;
  final Key? key;
  const CircleProgressBar({
    required this.timeRemaining,
    required this.strokeWidth,
    required this.radius,
    this.key,
  }) : super(key: key);

  @override
  State<CircleProgressBar> createState() => _CircleProgressBarState();
}

class _CircleProgressBarState extends State<CircleProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.timeRemaining),
    );
    _animation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: CircleProgressBarPainter(
                progress: _animation.value,
                strokeWidth: widget.strokeWidth,
              ),
              child: SizedBox(
                width: widget.radius * 2,
                height: widget.radius * 2,
              ),
            ),
            SizedBox(
              width: widget.radius * 2,
              height: widget.radius * 2,
              child: Center(
                child: Text(
                  '${widget.timeRemaining ~/ 60}:${(widget.timeRemaining % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: widget.radius * 0.4,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CircleProgressBarPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;

  CircleProgressBarPainter({
    required this.progress,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    const startAngle = -90.0 * (pi / 180);
    final sweepAngle = 360.0 * progress * (pi / 180);

    final remainingPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final elapsedPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      remainingPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle + sweepAngle,
      360.0 * (1 - progress) * (pi / 180),
      false,
      elapsedPaint,
    );
  }

  @override
  bool shouldRepaint(CircleProgressBarPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        strokeWidth != oldDelegate.strokeWidth;
  }
}
