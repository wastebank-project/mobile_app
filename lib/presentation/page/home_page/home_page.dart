import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:waste_app/presentation/widgets/images_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset('assets/png/bg.png'),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 40, 25, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    maxRadius: 50,
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/png/Logo only.png'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      Image.asset('assets/png/bg1.png'),
                      const Positioned(
                        left: 40,
                        bottom: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Selamat Datang,',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'BudiArieHambali',
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Artikel',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      Text(
                        'Lihat semua',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff7ABA78),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 140,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset('assets/png/bg2.png')),
                            ),
                            const Positioned(
                              bottom: 17,
                              left: 20,
                              child: Text(
                                'Manfaat Recycle \nuntuk Rumah Tangga',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset('assets/png/bg2.png')),
                            ),
                            const Positioned(
                              bottom: 17,
                              left: 20,
                              child: Text(
                                'Manfaat Recycle \nuntuk Rumah Tangga',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset('assets/png/bg2.png')),
                            ),
                            const Positioned(
                              bottom: 17,
                              left: 20,
                              child: Text(
                                'Manfaat Recycle \nuntuk Rumah Tangga',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset('assets/png/bg2.png')),
                            ),
                            const Positioned(
                              bottom: 17,
                              left: 20,
                              child: Text(
                                'Manfaat Recycle \nuntuk Rumah Tangga',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Galeri',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  const ImageSlider(),
                  const SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
