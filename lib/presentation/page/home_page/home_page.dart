import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:waste_app/presentation/page/home_page/methods/username.dart';
import 'package:waste_app/presentation/page/home_page/methods/logout.dart';
import 'package:waste_app/presentation/widgets/images_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Username(context),
                  LogoutButton(context),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Selamat Datang!',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              '"WasteApp" adalah aplikasi inovatif '
              'yang dirancang untuk memberdayakan pengelola bank sampah dalam '
              'menjaga lingkungan dengan menyediakan fitur deteksi sampah dan '
              'pencatatan transaksi sampah di Bank Sampah.'
              '\n\nAplikasi ini menggunakan teknologi pengenalan gambar dan kecerdasan buatan untuk '
              'mengidentifikasi jenis sampah dan rekomendasi daur ulang sampah.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 15, height: 1.7),
            ),
            SizedBox(
              height: 15,
            ),
            const ImageSlider(),
          ],
        ),
      ),
    );
  }
}
