import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waste_app/domain/ml.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class WasteDetection extends StatefulWidget {
  WasteDetection({super.key});

  @override
  State<WasteDetection> createState() => _WasteDetectionState();
}

class _WasteDetectionState extends State<WasteDetection> {
  File? _imageFile;
  final MLService mlService = MLService();

  Future<void> _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
      await _detectTrash(_imageFile!);
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
      await _detectTrash(_imageFile!);
    }
  }

  Future<void> _detectTrash(File inputImageFile) async {
    EasyLoading.show(status: "Loading");
    try {
      // Use MLService to detect trash and get the processed image
      File detectedImage = await mlService.detectTrash(inputImageFile);
      setState(() {
        _imageFile = detectedImage;
      });
    } catch (e) {
      // Handle errors from MLService
      print('Error: $e');
    }
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error loading preferences')),
          );
        } else if (snapshot.hasData) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Deteksi Sampah',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Gunakan fitur Pindai untuk mendeteksi jenis dan jumlah sampah',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        width: 400,
                        height: 400,
                        child: _imageFile != null
                            ? Image.file(_imageFile!)
                            : Image.asset(
                                'assets/png/placeholder.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        width: 250,
                        height: 40,
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFFF2994A))),
                          onPressed: () async {
                            await _takePicture();
                          },
                          icon:
                              const Icon(Icons.camera_alt, color: Colors.white),
                          label: const Text(
                            'Ambil foto',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                        width: 250,
                        height: 40,
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFFF2994A))),
                          onPressed: () async {
                            await _pickImage();
                          },
                          icon: const Icon(Icons.file_upload_outlined,
                              color: Colors.white),
                          label: const Text(
                            'Pilih foto',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(child: Text('Failed to load preferences')),
          );
        }
      },
    );
  }
}
