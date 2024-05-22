// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:final_submission/rest/ml.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../account/login_screen.dart';
// import '../global/toast.dart';

// class Recycle_Screen extends StatefulWidget {
//   @override
//   State<Recycle_Screen> createState() => _Recycle_ScreenState();
// }

// class _Recycle_ScreenState extends State<Recycle_Screen> {
//   final MLService mlService = MLService();
//   Map<String, dynamic>? detectionResult;
//   File? _imageFile;

//   // Buat instance dari MLService
//   Future<File?> _takePicture() async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//     if (image != null) {
//       setState(() {
//         _imageFile = File(image.path);
//       });
//       await _detectTrash(_imageFile!);
//     } else {
//       return null;
//     }
//   }

//   Future<File?> _pickImage() async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         _imageFile = File(image.path);
//       });
//       await _detectTrash(_imageFile!);
//     } else {
//       return null;
//     }
//   }

//   Future<void> _detectTrash(File inputImageFile) async {
//     if (inputImageFile != null) {
//       EasyLoading.show(status: "Loading");
//       try {
//         // Gunakan MLService untuk deteksi sampah
//         Map<String, dynamic> data = await mlService.detectTrash(inputImageFile);
//         detectionResult = data;
//         setState(() {});
//         // print('Response from API: $data');
//         // Tampilkan respons ke pengguna sesuai kebutuhan
//       } catch (e) {
//         // Tangani kesalahan dari MLService
//         print('Error: $e');
//       }
//       EasyLoading.dismiss();
//     }
//   }

//   Future<void> _pickAndDetectTrash() async {
//     File? imageFile = await _pickImage();
//     if (imageFile != null) {
//       await _detectTrash(imageFile);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<SharedPreferences>(
//       future: SharedPreferences.getInstance(),
//       builder:
//           (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
//         if (snapshot.hasData) {
//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.lightGreen,
//               title: Text("Recycle"),
//             ),
//             body: Center(
//                 child: SingleChildScrollView(
//               child: Container(
//                 padding: EdgeInsets.only(left: 15, right: 15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 10),
//                     Text(
//                       'Unggah Foto', // Replace with the actual user's name
//                       style: TextStyle(
//                           fontSize: 40,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: "Gabarito"),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Fitur ini menggunakan Image Detection yang bisa mendeteksi jenis sampah daur ulang yang anda foto', // Replace with the actual user's name
//                       style: TextStyle(fontSize: 14, fontFamily: "Gabarito"),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 20),
//                     Center(
//                       child: Column(
//                         children: <Widget>[
//                           // TODO MENAMPILKAN HASIL GAMBAR YANG SUDAH DI FOTO ATAU PICK FROM GALERI
//                           Container(
//                             width: 250,
//                             height: 400,
//                             child: _imageFile != null
//                                 ? Image.file(_imageFile!)
//                                 : Image.asset(
//                                     'assets/jpg/placeholder.jpg',
//                                     fit: BoxFit.cover,
//                                   ),
//                           ),
//                           SizedBox(height: 10),
//                           Text(
//                               'Akurasi: ${detectionResult?['accuracy'] ?? 'N/A'}'),
//                           Text(
//                               'Kelas: ${detectionResult?['class_label'] ?? 'N/A'}'),
//                           SizedBox(height: 30),
//                           ElevatedButton.icon(
//                             onPressed: () async {
//                               await _detectTrash(await _takePicture() as File);
//                             },
//                             icon: Icon(Icons.camera_alt),
//                             label: Text("Ambil Gambar"),
//                           ),
//                           ElevatedButton.icon(
//                             onPressed: () async {
//                               await _pickAndDetectTrash();
//                             },
//                             icon: Icon(Icons.upload),
//                             label: Text("Pilih dari Galeri"),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             )),
//           );
//         } else {
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }
