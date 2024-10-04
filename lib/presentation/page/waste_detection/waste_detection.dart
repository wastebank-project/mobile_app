import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waste_app/domain/yolo_service_tflite.dart';
import 'package:waste_app/presentation/widgets/zoomable_view.dart';
import 'package:waste_app/presentation/page/waste_detection/methods/models.dart';
import 'package:waste_app/presentation/page/waste_detection/methods/recomendation.dart';
import 'package:waste_app/tflite/yolo_bounding_box.dart';

class WasteDetection extends StatefulWidget {
  const WasteDetection({super.key});

  @override
  State<WasteDetection> createState() => _WasteDetectionState();
}

class _WasteDetectionState extends State<WasteDetection> {
  File? _imageFile;
  final YOLOService yoloService = YOLOService();
  List<YOLOPrediction> _predictions = [];

  @override
  void initState() {
    super.initState();
    yoloService.loadModel();
  }

// MENGAMBIL GAMBAR DENGAN MEMAKAI SUMBER DARI KAMERA
  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
      await _detectTrash(_imageFile!);
    }
  }

  Future<Size> _getImageSize(File imageFile) async {
    final Uint8List bytes = await imageFile.readAsBytes();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    return Size(
        frameInfo.image.width.toDouble(), frameInfo.image.height.toDouble());
  }

// MENGAMBIL GAMBAR DENGAN MEMAKAI SUMBER DARI GALERI
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
      await _detectTrash(_imageFile!);
    }
  }

// MENDETEKSI SAMPAH DENGAN API DETECTTRASH
  Future<void> _detectTrash(File inputImageFile) async {
    try {
      List<YOLOPrediction> predictions =
          await yoloService.detectTrash(inputImageFile);
      // ignore: avoid_print
      print("Predictions received: ${predictions.length}"); // Debug print
      setState(() {
        _predictions = predictions;
      });
      if (_predictions.isEmpty) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tidak ada Objek terdeteksi, mohon ulangi lagi'),
            duration: Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error in _detectTrash: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (_predictions.isEmpty)
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deteksi Sampah',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Gunakan fitur Pindai untuk mendeteksi jenis dan jumlah sampah',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              else
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hasil Deteksi Sampah',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Berikut adalah Hasil Deteksi Sampah yang sudah diunggah',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
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
                  child: SizedBox(
                    width: 400,
                    height: 400,
                    child: _imageFile != null
                        ? FutureBuilder<Size>(
                            future: _getImageSize(_imageFile!),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return LayoutBuilder(
                                  builder: (context, constraints) {
                                    double aspectRatio = snapshot.data!.width /
                                        snapshot.data!.height;
                                    double width = constraints.maxWidth;
                                    double height = width / aspectRatio;

                                    if (height > constraints.maxHeight) {
                                      height = constraints.maxHeight;
                                      width = height * aspectRatio;
                                    }

                                    return Stack(
                                      children: [
                                        Image.file(
                                          _imageFile!,
                                          fit: BoxFit.contain,
                                          width: width,
                                          height: height,
                                        ),
                                        CustomPaint(
                                          painter: BoundingBoxPainter(
                                            _predictions,
                                            snapshot.data!,
                                            Size(width, height),
                                          ),
                                          size: Size(width, height),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          )
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
                      decoration: const BoxDecoration(color: Color(0XFFF6F4BD)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _predictions.map((p) {
                            return Text(
                              '${p.label} (${(p.score * 100).toStringAsFixed(1)}%)',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              if (_predictions.isEmpty)
                Column(
                  children: [
                    Center(
                      child: SizedBox(
                        width: 171,
                        height: 45,
                        child: OutlinedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                                const Color(0xff7ABA78)),
                            side: WidgetStateProperty.all(
                              const BorderSide(
                                color: Color(0xff7ABA78),
                                width: 2,
                              ),
                            ),
                            shape: WidgetStateProperty.all(
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
                                WidgetStateProperty.all(Colors.transparent),
                            side: WidgetStateProperty.all(
                              const BorderSide(
                                color: Color(0xff7ABA78),
                                width: 2,
                              ),
                            ),
                            shape: WidgetStateProperty.all(
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
                    )
                  ],
                )
              else
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xff7ABA78),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RecomendationScreen(
                            recommendations: Models.fromLabels(
                                _predictions.map((p) => p.label).toList()),
                          );
                        }));
                      },
                      child: const Text(
                        'Rekomendasi Pengolahan',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
