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
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final double scaleX = displaySize.width / imageSize.width;
    final double scaleY = displaySize.height / imageSize.height;
    final double scale = scaleX < scaleY ? scaleX : scaleY;

    final double offsetX = (displaySize.width - imageSize.width * scale) / 2;
    final double offsetY = (displaySize.height - imageSize.height * scale) / 2;

    for (var prediction in predictions) {
      final rect = Rect.fromLTWH(
        prediction.boundingBox[0] * scale + offsetX,
        prediction.boundingBox[1] * scale + offsetY,
        prediction.boundingBox[2] * scale,
        prediction.boundingBox[3] * scale,
      );

      print("Drawing rect: $rect");
      canvas.drawRect(rect, paint);

      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text:
              "${prediction.label} (${(prediction.score * 100).toStringAsFixed(0)}%)",
          style: TextStyle(
              color: Colors.red, fontSize: 12, backgroundColor: Colors.white),
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
