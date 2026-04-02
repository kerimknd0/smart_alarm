import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// 0–100 arası uyku skoru gösteren animasyonlu halka widget'ı.
class SleepScoreRing extends StatefulWidget {
  final int score;
  final double size;
  final bool animate;

  const SleepScoreRing({
    super.key,
    required this.score,
    this.size = 160,
    this.animate = true,
  });

  @override
  State<SleepScoreRing> createState() => _SleepScoreRingState();
}

class _SleepScoreRingState extends State<SleepScoreRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _animation = Tween<double>(begin: 0, end: widget.score / 100.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    if (widget.animate) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _scoreColor(int score) {
    if (score >= 85) return AppColors.success;
    if (score >= 70) return AppColors.primary;
    if (score >= 50) return AppColors.snoozeColor;
    return AppColors.error;
  }

  String _scoreLabel(int score) {
    if (score >= 85) return 'Mükemmel';
    if (score >= 70) return 'İyi';
    if (score >= 50) return 'Orta';
    if (score >= 30) return 'Zayıf';
    return 'Çok Zayıf';
  }

  @override
  Widget build(BuildContext context) {
    final color = _scoreColor(widget.score);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        final progress = _animation.value;
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(widget.size, widget.size),
                painter: _RingPainter(
                  progress: progress,
                  color: color,
                  trackColor: color.withValues(alpha: 0.12),
                  strokeWidth: widget.size * 0.09,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${(progress * widget.score).round()}',
                    style: TextStyle(
                      fontSize: widget.size * 0.28,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    _scoreLabel(widget.score),
                    style: TextStyle(
                      fontSize: widget.size * 0.10,
                      color: AppColorsExtension.of(context).textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color trackColor;
  final double strokeWidth;

  const _RingPainter({
    required this.progress,
    required this.color,
    required this.trackColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Arka iz
    canvas.drawCircle(center, radius, trackPaint);

    // İlerleme yayı — saat 12'den başlar
    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // 12 o'clock
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.color != color;
}
