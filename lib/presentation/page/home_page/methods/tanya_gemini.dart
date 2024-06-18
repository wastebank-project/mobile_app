import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
            // MARKDOWN
            MarkdownBody(
              data: answer,
              selectable: true,
            ),
            // Text(answer),
            const SizedBox(height: 25),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 130,
        decoration: const BoxDecoration(
          color: Colors.white, // Ensure the container is transparent
          boxShadow: [
            BoxShadow(
              color: Colors.black12, // Slight shadow for better visibility
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 310,
                child: TextField(
                  controller: questionController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan pertanyaan saja atau dengan gambar',
                    hintStyle:
                        const TextStyle(fontSize: 11, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        ImagePicker()
                            .pickImage(source: ImageSource.gallery)
                            .then(
                          (value) {
                            setState(() {
                              image = value;
                            });
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.add_photo_alternate_outlined,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: IconButton(
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

                      // Simulasi GeneratedText menjadi perteks
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
                  icon: const Icon(
                    Icons.send,
                    color: Colors.green,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
