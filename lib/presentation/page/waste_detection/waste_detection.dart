import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WasteDetection extends StatefulWidget {
  WasteDetection({super.key});

  @override
  State<WasteDetection> createState() => _WasteDetectionState();
}

class _WasteDetectionState extends State<WasteDetection> {
  XFile? xfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
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
              Image.asset('assets/png/placeholder.png'),
              const SizedBox(height: 10),
              Center(
                child: SizedBox(
                  width: 250,
                  height: 40,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF7FB77E))),
                    onPressed: () {},
                    icon: const Icon(Icons.camera_alt, color: Colors.white),
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
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFF7FB77E))),
                    onPressed: () {},
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
  }
}
