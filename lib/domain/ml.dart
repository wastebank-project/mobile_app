import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart'; // Add this line

class MLService {
  Future<File> detectTrash(File inputImageFile) async {
    try {
      // Send image to the API using form-data
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://machinelearning-api-6znke3vbka-uc.a.run.app/predict'),
      );
      request.files.add(
        await http.MultipartFile.fromPath('image', inputImageFile.path),
      );

      // Send the request and receive the response
      var response = await request.send();
      if (response.statusCode == 200) {
        // Save the image to a temporary file
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
}
