import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url1 = Uri.parse(
    'https://www.linkedin.com/pulse/8-jenis-sampah-yang-bisa-didaur-ulang-dan-berpotensi-cuan-tanuwijaya/');

Future<void> _launchUrl1() async {
  if (!await launchUrl(_url1)) {
    throw Exception('Could not launch $_url1');
  }
}

final Uri _url2 = Uri.parse(
    'https://infografis.sindonews.com/photo/14035/mengenal-7-jenis-sampah-plastik-yang-bisa-didaur-ulang-1645814962');

Future<void> _launchUrl2() async {
  if (!await launchUrl(_url2)) {
    throw Exception('Could not launch $_url2');
  }
}

final Uri _url3 = Uri.parse(
    'https://radarjogja.jawapos.com/news/653103476/manfaat-daur-ulang-sampah-untuk-lingkungan-dan-ekonomi');

Future<void> _launchUrl3() async {
  if (!await launchUrl(_url3)) {
    throw Exception('Could not launch $_url3');
  }
}

final Uri _url4 = Uri.parse(
    'https://dlh.semarangkota.go.id/3-upaya-daur-ulang-sampah-menjadi-barang-layak-jual/');

Future<void> _launchUrl4() async {
  if (!await launchUrl(_url4)) {
    throw Exception('Could not launch $_url4');
  }
}

final Uri _url5 = Uri.parse(
    'https://www.kompas.id/baca/riset/2023/08/12/menumbuhkan-kesadaran-mengelola-sampah-melalui-bank-sampah');

Future<void> _launchUrl5() async {
  if (!await launchUrl(_url5)) {
    throw Exception('Could not launch $_url5');
  }
}

final Uri _url6 = Uri.parse(
    'https://www.cleanipedia.com/id/apa-itu-bank-sampah-dan-bagaimana-mekanismenya.html');

Future<void> _launchUrl6() async {
  if (!await launchUrl(_url6)) {
    throw Exception('Could not launch $_url6');
  }
}

final Uri _url7 = Uri.parse(
    'https://www.rinso.com/id/sustainability/manfaat-bank-sampah-dan-cara-kerjanya-yang-perlu-diketahui.html');

Future<void> _launchUrl7() async {
  if (!await launchUrl(_url7)) {
    throw Exception('Could not launch $_url7');
  }
}

class MoreArticles extends StatelessWidget {
  const MoreArticles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Artikel Terkait',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SizedBox(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _launchUrl5();
                },
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/png/saving_bg4.png'),
                      ),
                    ),
                    const Positioned(
                      bottom: 15,
                      left: 15,
                      right: 5,
                      child: Text(
                        'Menumbuhkan Kesadaran Mengelola Sampah melalui Bank Sampah',
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
                  _launchUrl1();
                },
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/png/saving_bg1.png'),
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
                          child: Image.asset('assets/png/bg3.png')),
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
                  _launchUrl4();
                },
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/png/saving_bg3.png'),
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
              GestureDetector(
                onTap: () {
                  _launchUrl6();
                },
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/png/saving_bg5.png'),
                      ),
                    ),
                    const Positioned(
                      bottom: 15,
                      left: 15,
                      right: 5,
                      child: Text(
                        'Apa Itu Bank Sampah dan Bagaimana Mekanismenya?',
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
                        child: Image.asset('assets/png/saving_bg2.png'),
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
                  _launchUrl7();
                },
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/png/saving_bg6.png'),
                      ),
                    ),
                    const Positioned(
                      bottom: 15,
                      left: 15,
                      right: 5,
                      child: Text(
                        'MANFAAT BANK SAMPAH DAN CARA KERJANYA YANG PERLU DIKETAHUI',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35)
            ],
          ),
        ),
      ),
    );
  }
}
