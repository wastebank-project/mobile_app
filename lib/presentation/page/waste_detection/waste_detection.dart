import 'package:flutter/material.dart';

class WasteDetection extends StatelessWidget {
  const WasteDetection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                'Gunakan fitur Pindai untuk mendeteksi jenis dan jumlah sampah'),
          ],
        ),
      ),
    );
  }
}
