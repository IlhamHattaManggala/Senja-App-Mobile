import 'package:flutter/material.dart';

class LandmarkPainter extends CustomPainter {
  final List<Offset> landmarks;
  LandmarkPainter(this.landmarks);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3.0;

    for (final point in landmarks) {
      canvas.drawCircle(point, 5.0, paint);
    }

    // Contoh garis antar titik (misal 0 ke 1, 1 ke 2, dst)
    for (int i = 0; i < landmarks.length - 1; i++) {
      canvas.drawLine(landmarks[i], landmarks[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(LandmarkPainter oldDelegate) =>
      oldDelegate.landmarks != landmarks;
}
