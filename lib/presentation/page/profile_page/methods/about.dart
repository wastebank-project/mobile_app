import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Tentang Aplikasi',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              '"WasteApp" adalah aplikasi inovatif yang dirancang untuk memberdayakan pengelola bank sampah dalam menjaga lingkungan dengan menyediakan fitur deteksi sampah dan pencatatan transaksi sampah di bank sampah.\n\n Aplikasi ini menggunakan teknologi pengenalan gambar dan kecerdasan buatan untuk mengidentifikasi jenis sampah dan rekomendasi recycle sampah.',
              style: TextStyle(height: 1.7),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        height: 50,
        color: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                  const BorderSide(color: Color(0xFF7ABA78), width: 2.5)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
            ),
            child: const Text("Kembali",
                style: TextStyle(
                    color: Color(0xFF7ABA78),
                    fontSize: 15,
                    fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}
