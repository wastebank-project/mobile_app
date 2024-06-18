import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class TanyaGemini extends StatefulWidget {
  const TanyaGemini({super.key});

  @override
  State<TanyaGemini> createState() => _TanyaGeminiState();
}

class _TanyaGeminiState extends State<TanyaGemini> {
  TextEditingController questionController = TextEditingController();
  String answer = '';
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tanya Gemini'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            const SizedBox(height: 25),
            TextField(
              controller: questionController,
              decoration: const InputDecoration(
                hintText: 'Masukkan pertanyaan saja atau dengan gambar',
                hintStyle: TextStyle(fontSize: 11, color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: image == null ? Colors.grey.shade200 : null,
                image: image != null
                    ? DecorationImage(image: FileImage(File(image!.path)))
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                side: MaterialStateProperty.all(
                  const BorderSide(
                    color: Color(0xff7ABA78),
                    width: 2.5,
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () async {
                ImagePicker().pickImage(source: ImageSource.gallery).then(
                  (value) {
                    setState(() {
                      image = value;
                    });
                  },
                );
              },
              icon: const Icon(Icons.file_upload_outlined,
                  color: Color(0xff7ABA78)),
              label: const Text('Pilih foto',
                  style: TextStyle(
                      color: Color(0xFF7ABA78),
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 5),
            TextButton(
              onPressed: () async {
                EasyLoading.show(status: 'Loading...');
                setState(() {
                  answer = ''; // CLEAR JAWABAN SEBELUMNYA
                });
                try {
                  GenerativeModel model = GenerativeModel(
                    model: 'gemini-1.5-flash-latest',
                    apiKey: dotenv.env['API_KEY']!,
                  );

                  final result = await model.generateContent([
                    Content.multi([
                      TextPart(questionController.text),
                      if (image != null)
                        DataPart(
                          'image/jpeg',
                          File(image!.path).readAsBytesSync(),
                        ),
                    ]),
                  ]);

                  // Simulate streaming by splitting the response into chunks
                  final generatedText = result.text.toString();
                  for (int i = 0; i < generatedText.length; i++) {
                    await Future.delayed(const Duration(milliseconds: 10));
                    setState(() {
                      answer += generatedText[i];
                    });
                  }
                } catch (e) {
                  print("Error generating content: $e");
                } finally {
                  EasyLoading.dismiss();
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff7ABA78)),
                side: MaterialStateProperty.all(
                  const BorderSide(
                    color: Color(0xff7ABA78),
                    width: 2,
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              child: const Text("Kirim",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 20),
            Text(answer),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
