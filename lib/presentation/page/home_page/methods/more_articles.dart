import 'package:flutter/material.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: Text(
            //     'Artikel Terkait',
            //     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
            //   ),
            // ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/png/bg3.png')),
                ),
                const Positioned(
                  bottom: 25,
                  left: 30,
                  child: Text(
                    'Manfaat Recycle untuk pengurangan \nSampah Rumah Tangga',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/png/bg3.png')),
                ),
                const Positioned(
                  bottom: 25,
                  left: 30,
                  child: Text(
                    'Manfaat Recycle untuk pengurangan \nSampah Rumah Tangga',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/png/bg3.png')),
                ),
                const Positioned(
                  bottom: 25,
                  left: 30,
                  child: Text(
                    'Manfaat Recycle untuk pengurangan \nSampah Rumah Tangga',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/png/bg3.png')),
                ),
                const Positioned(
                  bottom: 25,
                  left: 30,
                  child: Text(
                    'Manfaat Recycle untuk pengurangan \nSampah Rumah Tangga',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/png/bg3.png')),
                ),
                const Positioned(
                  bottom: 25,
                  left: 30,
                  child: Text(
                    'Manfaat Recycle untuk pengurangan \nSampah Rumah Tangga',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
