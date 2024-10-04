// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:waste_app/domain/yolo_service_tflite.dart';

class BoundingBoxPainter extends CustomPainter {
  final List<YOLOPrediction> predictions;
  final Size imageSize;
  final Size displaySize;

  BoundingBoxPainter(this.predictions, this.imageSize, this.displaySize) {
    print("BoundingBoxPainter constructor called");
    print("Predictions: $predictions");
    print("Image size: $imageSize");
    print("Display size: $displaySize");
  }

  @override
  void paint(Canvas canvas, Size size) {
    print("paint method called");
    final paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final double scaleX = size.width / 640; // 640 is the YOLO model input size
    final double scaleY = size.height / 640;

    for (var prediction in predictions) {
      final rect = Rect.fromLTWH(
        prediction.boundingBox[0] * scaleX,
        prediction.boundingBox[1] * scaleY,
        prediction.boundingBox[2] * scaleX,
        prediction.boundingBox[3] * scaleY,
      );

      print("Drawing rect: $rect");
      canvas.drawRect(rect, paint);

      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text:
              "${prediction.label} (${(prediction.score * 100).toStringAsFixed(0)}%)",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            backgroundColor: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(rect.left, rect.top - 15));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
