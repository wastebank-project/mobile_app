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
      appBar: AppBar(
        title: const Text('Rekomendasi Pengolahan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: recommendations.map((rec) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${rec.label}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () async {
                    if (await canLaunch(rec.youtubeLink)) {
                      await launch(rec.youtubeLink);
                    } else {
                      throw 'Could not launch ${rec.youtubeLink}';
                    }
                  },
                  child: Text(
                    rec.youtubeLink,
                    style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
