import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waste_app/presentation/page/home_page/methods/more_articles.dart';
import 'package:waste_app/presentation/page/home_page/methods/tanya_gemini.dart';
import 'package:waste_app/presentation/widgets/images_slider.dart';

final Uri _url1 = Uri.parse(
    'https://www.linkedin.com/pulse/8-jenis-sampah-yang-bisa-didaur-ulang-dan-berpotensi-cuan-tanuwijaya/');

final Uri _url2 = Uri.parse(
    'https://infografis.sindonews.com/photo/14035/mengenal-7-jenis-sampah-plastik-yang-bisa-didaur-ulang-1645814962');

final Uri _url3 = Uri.parse(
    'https://radarjogja.jawapos.com/news/653103476/manfaat-daur-ulang-sampah-untuk-lingkungan-dan-ekonomi');

final Uri _url4 = Uri.parse(
    'https://dlh.semarangkota.go.id/3-upaya-daur-ulang-sampah-menjadi-barang-layak-jual/');

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.username});
  final String username;

// FUNGSI GREETING BY TIME
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat Pagi!';
    } else if (hour < 15) {
      return 'Selamat Siang!';
    } else if (hour < 19) {
      return 'Selamat Sore!';
    } else {
      return 'Selamat Malam!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset('assets/png/bg.png'),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 35, 25, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    maxRadius: 45,
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/png/Logo only.png'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      Image.asset('assets/png/bg1.png'),
                      Positioned(
                        left: 30,
                        bottom: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _getGreeting(),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              username,
                              style: const TextStyle(
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
                  const SizedBox(height: 20),
                  const Text(
                    'Galeri',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  const ImageSlider(),
                  const SizedBox(height: 10),
                  const Text(
                    'Tanya Gemini',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const TanyaGemini();
                      }));
                    },
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/png/gemini3.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'Artikel',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const MoreArticles();
                          }));
                        },
                        child: const Text(
                          'Lihat Semua',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xff7ABA78),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 135,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _launchUrl1();
                          },
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child:
                                      Image.asset('assets/png/saving_bg1.png'),
                                ),
                              ),
                              const Positioned(
                                bottom: 15,
                                left: 15,
                                right: 5,
                                child: Text(
                                  'Jenis Sampah yang Didaur Ulang\ndan Berpotensi Cuan',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchUrl2();
                          },
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset('assets/png/bg2.png')),
                              ),
                              const Positioned(
                                bottom: 15,
                                left: 15,
                                right: 15,
                                child: Text(
                                  '7 Jenis Sampah Plastik\nyang bisa Didaur Ulang ',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchUrl3();
                          },
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child:
                                      Image.asset('assets/png/saving_bg2.png'),
                                ),
                              ),
                              const Positioned(
                                bottom: 15,
                                left: 15,
                                right: 5,
                                child: Text(
                                  'Manfaat Daur Ulang Sampah\nuntuk Lingkungan dan Ekonomi',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchUrl4();
                          },
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child:
                                      Image.asset('assets/png/saving_bg3.png'),
                                ),
                              ),
                              const Positioned(
                                bottom: 15,
                                left: 15,
                                right: 5,
                                child: Text(
                                  '3 Upaya Daur Ulang Sampah Menjadi Barang Layak Jual',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _launchUrl1() async {
  if (!await launchUrl(_url1)) {
    throw Exception('Could not launch $_url1');
  }
}

Future<void> _launchUrl2() async {
  if (!await launchUrl(_url2)) {
    throw Exception('Could not launch $_url2');
  }
}

Future<void> _launchUrl3() async {
  if (!await launchUrl(_url3)) {
    throw Exception('Could not launch $_url3');
  }
}

Future<void> _launchUrl4() async {
  if (!await launchUrl(_url4)) {
    throw Exception('Could not launch $_url4');
  }
}
