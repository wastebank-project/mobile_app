import 'package:flutter/material.dart';
import 'package:waste_app/domain/yolo_service_tflite.dart';

class BoundingBoxPainter extends CustomPainter {
  final List<YOLOPrediction> predictions;
  final Size imageSize;
  final Size displaySize;

  BoundingBoxPainter(this.predictions, this.imageSize, this.displaySize);

  // Define a map of class labels to colors
  final Map<String, Color> labelColors = {
    'Botol Kaca': Colors.blue,
    'Botol Plastik': Colors.green,
    'Galon': Colors.red,
    'Gelas Plastik': Colors.white,
    'Kaleng': Colors.amber,
    'Kantong Plastik': Colors.cyan,
    'Kantong Semen': Colors.lightBlue,
    'Kardus': Colors.limeAccent,
    'Kemasan Plastik': Colors.tealAccent,
    'Kertas Bekas': Colors.redAccent,
    'Koran': Colors.purpleAccent,
    'Pecahan Kaca': Colors.pinkAccent,
    'Toples Kaca': Colors.indigoAccent,
    'Tutup Galon': Colors.deepOrangeAccent,
  };

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / 640; // 640 is the YOLO model input size
    final double scaleY = size.height / 640;

    for (var prediction in predictions) {
      final rect = Rect.fromLTWH(
        prediction.boundingBox[0] * scaleX,
        prediction.boundingBox[1] * scaleY,
        prediction.boundingBox[2] * scaleX,
        prediction.boundingBox[3] * scaleY,
      );

      // Get the color for the label and bounding box, or use a default color
      final labelColor = labelColors[prediction.label] ?? Colors.yellow;

      // Draw the bounding box with the color based on the label
      final paint = Paint()
        ..color = labelColor // Set the color based on the label
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0;
      canvas.drawRect(rect, paint);

      // Draw the label with the corresponding color
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text:
              "${prediction.label} (${(prediction.score * 100).toStringAsFixed(0)}%)",
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            backgroundColor: labelColor, // Use the color based on the label
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
