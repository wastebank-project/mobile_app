import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class MLService {
  Future<File> detectTrash(File inputImageFile) async {
    try {
      // Send image to the API using form-data
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${dotenv.env['BASE_ML_YOLO']}/image'),
      );
      request.files.add(
        await http.MultipartFile.fromPath('image', inputImageFile.path),
      );

      // Send the request and receive the response
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        var tempDir = await getTemporaryDirectory();
        File tempFile = File('${tempDir.path}/detected_image.png');
        await tempFile.writeAsBytes(responseData);

        return tempFile;
      } else {
        // Handle failed response
        throw Exception(
            'Failed to detect trash. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle connection or other errors
      throw Exception('Error: $e');
    }
  }

  Future<List<Prediction>> detectText(File inputFile) async {
    try {
      var uri = Uri.parse(
        '${dotenv.env['BASE_ML_YOLO']}/text',
      );

      var request = http.MultipartRequest('POST', uri);
      request.files.add(
        await http.MultipartFile.fromPath('image', inputFile.path),
      );

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseData);
        var predictions = jsonResponse['predictions'] as List;
        List<Prediction> predictionList = predictions
            .map((prediction) => Prediction(
                  label: prediction['label'] as String,
                  score: prediction['score'] as double,
                ))
            .toList();

        return predictionList;
      } else {
        throw Exception(
            'Failed to process text. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

class Prediction {
  final String label;
  final double score;

  Prediction({required this.label, required this.score});

  @override
  String toString() {
    return '$label (${(score * 100).toStringAsFixed(2)}%)';
  }
}
