import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waste_app/presentation/page/waste_detection/methods/models.dart';

class RecomendationScreen extends StatelessWidget {
  final List<Models> recommendations;

  const RecomendationScreen({Key? key, required this.recommendations})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rekomendasi Pengolahan',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: recommendations.map((rec) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rec.label,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          ...rec.youtubeRecommendations.map((recommendation) =>
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      recommendation['heading']!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        final url = recommendation['link']!;
                                        print('Attempting to launch URL: $url');
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                          print(
                                              'Successfully launched URL: $url');
                                        } else {
                                          print('Could not launch URL: $url');
                                          throw 'Could not launch $url';
                                        }
                                      },
                                      child: Text(
                                        recommendation['link']!,
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
