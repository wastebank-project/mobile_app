import 'dart:io';
import 'dart:typed_data';
import 'dart:math';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class YOLOService {
  Interpreter? _interpreter;

  YOLOService() {
    loadModel();
  }

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset(
          'assets/model/YOLOv8s_e100_lr0.0001_32_int8.tflite');
    } catch (e) {
      print("Error loading model: $e");
    }
  }

  Future<List<YOLOPrediction>> detectTrash(File imageFile) async {
    Uint8List imageBytes = await imageFile.readAsBytes();
    Uint8List input = preprocessImage(imageBytes);

    var outputShape = [1, 18, 8400];
    var output = List.generate(
        outputShape[0],
        (index) => List.generate(outputShape[1],
            (index) => List<double>.filled(outputShape[2], 0.0)));

    _interpreter?.run(input, output);

    List<YOLOPrediction> predictions =
        postprocessOutput(output[0], 0.25, 640, 640);
    return predictions;
  }

  Uint8List preprocessImage(Uint8List imageBytes) {
    img.Image? image = img.decodeImage(imageBytes);
    if (image == null) {
      throw Exception('Failed to decode image');
    }

    img.Image resizedImage = img.copyResize(image, width: 640, height: 640);
    Float32List input = Float32List(1 * 3 * 640 * 640);
    int pixelIndex = 0;

    for (int y = 0; y < 640; y++) {
      for (int x = 0; x < 640; x++) {
        img.Pixel pixel = resizedImage.getPixel(x, y);
        input[pixelIndex++] = pixel.r / 255.0;
        input[pixelIndex++] = pixel.g / 255.0;
        input[pixelIndex++] = pixel.b / 255.0;
      }
    }

    return input.buffer.asUint8List();
  }

  List<YOLOPrediction> postprocessOutput(List<List<double>> outputs,
      double threshold, int imageWidth, int imageHeight) {
    List<YOLOPrediction> allPredictions = [];

    print("Processing output...");

    for (int i = 0; i < outputs[0].length; i++) {
      List<double> detection = [];
      for (int j = 0; j < outputs.length; j++) {
        detection.add(outputs[j][i]);
      }

      List<double> classScores = detection.sublist(4);
      double maxClassScore = classScores.reduce((a, b) => a > b ? a : b);

      if (maxClassScore > threshold) {
        int classIndex = classScores.indexOf(maxClassScore);
        String label = classNames[classIndex];

        double xCenter = detection[0] * imageWidth;
        double yCenter = detection[1] * imageHeight;
        double boxWidth = detection[2] * imageWidth;
        double boxHeight = detection[3] * imageHeight;

        double topLeftX = xCenter - (boxWidth / 2);
        double topLeftY = yCenter - (boxHeight / 2);

        YOLOPrediction prediction = YOLOPrediction(
          label: label,
          score: maxClassScore,
          boundingBox: [topLeftX, topLeftY, boxWidth, boxHeight],
        );

        allPredictions.add(prediction);
      }
    }

    // Apply Non-Maximum Suppression
    List<YOLOPrediction> nmsResults = applyNMS(allPredictions, 0.5);

    // Keep only the highest confidence prediction for each class
    Map<String, YOLOPrediction> bestPredictions = {};
    for (var prediction in nmsResults) {
      if (!bestPredictions.containsKey(prediction.label) ||
          prediction.score > bestPredictions[prediction.label]!.score) {
        bestPredictions[prediction.label] = prediction;
      }
    }

    List<YOLOPrediction> finalPredictions = bestPredictions.values.toList();

    print("Total predictions: ${finalPredictions.length}");
    for (var prediction in finalPredictions) {
      print(
          "Detected object: Label=${prediction.label}, Score=${prediction.score}, Box=${prediction.boundingBox}");
    }

    return finalPredictions;
  }

  List<YOLOPrediction> applyNMS(
      List<YOLOPrediction> boxes, double iouThreshold) {
    boxes.sort((a, b) => b.score.compareTo(a.score));
    List<YOLOPrediction> selected = [];

    for (var current in boxes) {
      bool shouldSelect = selected.every((box) =>
          calculateIOU(current.boundingBox, box.boundingBox) < iouThreshold ||
          current.label != box.label);

      if (shouldSelect) {
        selected.add(current);
      }
    }

    return selected;
  }

  double calculateIOU(List<double> box1, List<double> box2) {
    double intersectionArea = calculateIntersectionArea(box1, box2);
    double box1Area = box1[2] * box1[3];
    double box2Area = box2[2] * box2[3];
    double unionArea = box1Area + box2Area - intersectionArea;
    return intersectionArea / unionArea;
  }

  double calculateIntersectionArea(List<double> box1, List<double> box2) {
    double x1 = max(box1[0], box2[0]);
    double y1 = max(box1[1], box2[1]);
    double x2 = min(box1[0] + box1[2], box2[0] + box2[2]);
    double y2 = min(box1[1] + box1[3], box2[1] + box2[3]);

    double width = max(0, x2 - x1);
    double height = max(0, y2 - y1);

    return width * height;
  }
}

class YOLOPrediction {
  final String label;
  final double score;
  final List<double> boundingBox;

  YOLOPrediction({
    required this.label,
    required this.score,
    required this.boundingBox,
  });
}

final classNames = [
  'Botol Kaca',
  'Botol Plastik',
  'Galon',
  'Gelas Plastik',
  'Kaleng',
  'Kantong Plastik',
  'Kantong Semen',
  'Kardus',
  'Kemasan Plastik',
  'Kertas Bekas',
  'Koran',
  'Pecahan Kaca',
  'Toples Kaca',
  'Tutup Galon'
];
