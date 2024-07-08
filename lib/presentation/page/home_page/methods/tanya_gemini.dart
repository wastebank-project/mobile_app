import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waste_app/presentation/widgets/floating_icon_button.dart';

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
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
        child: Row(
          children: [
            // EXPAND FOR TEXTFIELD
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: questionController,
                  decoration: InputDecoration(
                    // MENGURANGI PADDING DALAM TEXTFIELD
                    contentPadding: const EdgeInsets.all(10),
                    hintText: 'Tanyakan sesuatu mengenai sampah',
                    hintStyle:
                        const TextStyle(fontSize: 12, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
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
            ),
            const SizedBox(
              width: 5,
            ),
            SizedBox(
              width: 45,
              child: FloatingIconButton(
                iconData: Icons.send,
                onPressed: () async {
                  EasyLoading.show(status: 'Loading...');
                  setState(() {
                    answer = ''; // Clear previous answer
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

                    // Simulate generated text as per text
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
                color: Colors.green,
                iconSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
