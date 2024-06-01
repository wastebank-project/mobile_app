import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waste_app/domain/ml.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:waste_app/domain/zoomable_view.dart';
import 'package:waste_app/presentation/page/waste_detection/methods/models.dart';
import 'package:waste_app/presentation/page/waste_detection/methods/recomendation.dart';

class WasteDetection extends StatefulWidget {
  const WasteDetection({super.key});

  @override
  State<WasteDetection> createState() => _WasteDetectionState();
}

class _WasteDetectionState extends State<WasteDetection> {
  File? _imageFile;
  final MLService mlService = MLService();
  List<Prediction> _predictions = [];

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
      List<Prediction> predictions = await mlService.detectText(inputImageFile);

      setState(() {
        _imageFile = detectedImage;
        _predictions = predictions;
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
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Error loading preferences')),
          );
        } else if (snapshot.hasData) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.fromLTRB(25, 100, 25, 0),
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
                      child: GestureDetector(
                        onTap: () {
                          if (_imageFile != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ZoomableImageView(imageFile: _imageFile!),
                              ),
                            );
                          }
                        },
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
                    ),
                    const SizedBox(height: 20),
                    if (_predictions.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Sampah terdeteksi:',
                          ),
                          const SizedBox(height: 5),
                          Container(
                            decoration:
                                const BoxDecoration(color: Color(0XFFF6F4BD)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                _predictions.join('\n'),
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return RecomendationScreen(
                                      recommendations: Models.fromLabels(
                                          _predictions
                                              .map((p) => p.label)
                                              .toList()),
                                    );
                                  }));
                                },
                                child: const Text(
                                  'Rekomendasi Pengolahan >',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.green,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        width: 171,
                        height: 45,
                        child: OutlinedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xff7ABA78)),
                            side: MaterialStateProperty.all(
                              const BorderSide(
                                color: Color(0xff7ABA78),
                                width: 2,
                              ),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            await _takePicture();
                          },
                          icon: const Icon(Icons.camera_alt_sharp,
                              color: Colors.white),
                          label: const Text(
                            'Ambil Foto',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: SizedBox(
                        width: 171,
                        height: 45,
                        child: OutlinedButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            side: MaterialStateProperty.all(
                              const BorderSide(
                                color: Color(0xff7ABA78),
                                width: 2,
                              ),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            await _pickImage();
                          },
                          icon: const Icon(Icons.file_upload_outlined,
                              color: Color(0xff7ABA78)),
                          label: const Text(
                            'Pilih foto',
                            style: TextStyle(
                              color: Color(0xff7ABA78),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100)
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: Text('Failed to load preferences')),
          );
        }
      },
    );
  }
}
