import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:waste_app/domain/yolo_service_tflite.dart';
import 'package:waste_app/presentation/page/saving_page/result/saving_success.dart';
import 'package:waste_app/presentation/widgets/date_picker.dart';
import 'package:waste_app/presentation/widgets/text_fields_customers.dart';
import 'package:waste_app/presentation/widgets/waste_item_row.dart';
import 'package:waste_app/presentation/widgets/zoomable_view.dart';
import 'package:http/http.dart' as http;
import 'package:waste_app/tflite/yolo_bounding_box.dart';

class SavingWasteScreen extends StatefulWidget {
  const SavingWasteScreen({super.key});

  @override
  State<SavingWasteScreen> createState() => _SavingWasteScreenState();
}

class _SavingWasteScreenState extends State<SavingWasteScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  String? _errorMessage;
  OverlayEntry? _overlayEntry;
  List<String> names = [];
  List<Map<String, String>> wasteTypes = [];
  List<Map<String, dynamic>> wasteItems = [];
  Map<int, double> itemTotals = {};
  File? _imageFile;
  final YOLOService yoloService = YOLOService();
  List<YOLOPrediction> _predictions = [];
  bool _isloading = false; // NEW CIRCULARPROGRESSINDICATOR

// MENGAMBIL GAMBAR DENGAN MEMAKAI SUMBER DARI KAMERA
  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
      await _detectTrash(_imageFile!);
    }
  }

// MENGAMBIL GAMBAR DENGAN MEMAKAI SUMBER DARI GALERI
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
      await _detectTrash(_imageFile!);
    }
  }

// MENDETEKSI SAMPAH DENGAN API DETECTTRASH
  // MENDETEKSI SAMPAH DENGAN API DETECTTRASH
  Future<void> _detectTrash(File inputImageFile) async {
    try {
      List<YOLOPrediction> predictions =
          await yoloService.detectTrash(inputImageFile);
      print("Predictions received: ${predictions.length}");

      if (predictions.isEmpty) {
        // Handle empty predictions
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tidak ada Objek terdeteksi, mohon ulangi lagi'),
            duration: Duration(seconds: 4),
          ),
        );
        return;
      }

      // ***KEY CHANGE: Await fetchWasteTypes before updating state***
      await fetchWasteTypes();

      setState(() {
        _predictions = predictions;

        // ***KEY CHANGE: Update existing items or add new ones***
        for (var prediction in predictions) {
          final matchingWasteType = wasteTypes.firstWhere(
            (wasteType) => wasteType['name'] == prediction.label,
            orElse: () => {'id': '', 'name': 'Unknown'}, // Default to 'Unknown'
          );

          bool found = false;
          for (var item in wasteItems) {
            if (item['wasteType'] == matchingWasteType['name']) {
              // If waste type already exists, just update the amount (if needed)
              // You might want to add logic here to handle multiple detections of the same type
              // For example, summing the amounts or using the highest confidence prediction.
              item['amount'] =
                  ''; // Or some other logic for updating the amount
              found = true;
              break;
            }
          }

          if (!found) {
            // If waste type doesn't exist, add a new item
            wasteItems.add({
              'wasteType': matchingWasteType['name']!,
              'amount': '',
            });
          }
        }
      });
    } catch (e) {
      print('Error in _detectTrash: $e');
      // Handle the error appropriately, perhaps by showing a SnackBar
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error detecting trash: $e')));
    }
  }

// MENDAPATKAN IMAGE SIZE
  Future<Size> _getImageSize(File imageFile) async {
    final Uint8List bytes = await imageFile.readAsBytes();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    return Size(
        frameInfo.image.width.toDouble(), frameInfo.image.height.toDouble());
  }

// PENAMBAHAN WASTE ITEM ROW
  void addWasteItem() {
    setState(() {
      wasteItems.add({'wasteType': '', 'amount': ''});
    });
  }

// PENGHAPUSAN WASTE ITEM
  void deleteWasteItem(int index) {
    setState(() {
      wasteItems.removeAt(index);
      itemTotals.remove(index);
      calculateOverallTotal();
    });
  }

// HAPUS WASTE ITEM TERAKHIR
  void deleteLastWasteItem() {
    if (wasteItems.isNotEmpty) {
      setState(() {
        int lastIndex = wasteItems.length - 1;
        wasteItems.removeLast();
        itemTotals.remove(lastIndex);
        calculateOverallTotal();
      });
    }
  }

// PENJUMLAHAN PERITEM
  void updateItemTotal(int index, double total) {
    setState(() {
      itemTotals[index] = total;
      calculateOverallTotal();
    });
  }

// PENJUMLAHAN SUM TOTAL ITEM
  double calculateOverallTotal() {
    double total = 0;
    itemTotals.forEach((_, value) {
      total += value;
    });
    return total;
  }

// MEMBERSIHKAN FORM
  void _clearForm() {
    setState(() {
      nameController.clear();
      dateController.clear();
      wasteItems.clear();
      wasteItems.add({'wasteType': '', 'amount': ''});
      itemTotals.clear();
      _errorMessage = null;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchName();
    fetchWasteTypes();
    wasteItems.add({'wasteType': '', 'amount': ''}); // Start with one row
  }

// MENDAPATKAN NAMA BASED ON GET /NASABAH
  Future<void> fetchName() async {
    final response =
        await http.get(Uri.parse('${dotenv.env['BASE_URL_BACKEND']}/nasabah'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        names = data.map((e) => e['name'] as String).toList();
        names.sort();
      });
    } else {
      setState(() {
        _errorMessage = 'Failed to load data';
      });
    }
  }

// MENDAPATKAN WASTE TYPE
  Future<void> fetchWasteTypes() async {
    final response = await http
        .get(Uri.parse('${dotenv.env['BASE_URL_BACKEND']}/wastetypes'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        wasteTypes = data
            .map((e) => {
                  'id': e['id'] as String,
                  'name': e['name'] as String,
                })
            .toList();
        wasteTypes.sort((a, b) => a['name']!.compareTo(b['name']!));
      });
    } else {
      setState(() {
        _errorMessage = 'Failed to load data';
      });
    }
  }

// DROPDOWN NAME
  void _showDropdownName(BuildContext context, RenderBox renderBox) {
    final overlay = Overlay.of(context);
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: size.width,
        child: Material(
          elevation: 4.0,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 300),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: names.map((String name) {
                return ListTile(
                  title: Text(name),
                  onTap: () {
                    setState(() {
                      nameController.text = name;
                    });
                    _overlayEntry?.remove();
                    _overlayEntry = null;
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
    overlay.insert(_overlayEntry!);
  }

// FUNGSI UNTUK OVERLAY DROPDOWN WHEN PREVIOUS PAGE
  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  Future<void> _submitDeposits() async {
    List<Map<String, dynamic>> deposits = [];
    setState(() {
      _isloading = true;
      _errorMessage = null;
    });

    // Filter out empty waste items
    for (var item in wasteItems) {
      if (item['wasteType'].isNotEmpty && item['amount'].isNotEmpty) {
        final selectedWasteType = wasteTypes
            .firstWhere((wasteType) => wasteType['name'] == item['wasteType']);
        deposits.add({
          'wasteTypeId': selectedWasteType['id'],
          'amount': double.parse(item['amount']),
        });
      }
    }
    if (nameController.text.isEmpty || dateController.text.isEmpty) {
      setState(() {
        _isloading = false;
        _errorMessage = 'Tolong isi Semua Data!';
      });
      return;
    } else if (deposits.isEmpty) {
      setState(() {
        _isloading = false;
        _errorMessage = 'Tolong isi setidaknya satu jenis sampah dan jumlah!';
      });
      return; // Exit the function if no valid waste items exist
    }
    try {
      Future.delayed(const Duration(seconds: 3));
      final response = await http.post(
        Uri.parse('${dotenv.env['BASE_URL_BACKEND']}/tabung'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': nameController.text,
          'date': dateController.text,
          'deposits': deposits,
        }),
      );
      setState(() {
        _isloading = false; // Hide loading indicator after response
      });
      if (response.statusCode == 500 || response.statusCode == 201) {
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => const SavingSuccess(),
          ),
        );
        _clearForm();
      }
    } catch (e) {
      setState(() {
        _isloading = false;
        _errorMessage = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat(
        '#,##0', 'id_ID'); // FORMAT RIBUAN PEMISAH INDONESIA LOCALIZATION
    // ignore: avoid_print
    // print("Building with ${wasteItems.length} waste items");

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tabung Sampah',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            if (_predictions.isEmpty)
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gunakan fitur Pindai untuk mendeteksi jenis dan jumlah sampah',
                  ),
                ],
              )
            else
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hasil Deteksi Sampah',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            Center(
              child: GestureDetector(
                onTap: () {
                  if (_imageFile != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ZoomableImageView(imageFile: _imageFile!),
                      ),
                    );
                  }
                },
                child: SizedBox(
                  width: 400,
                  height: 400,
                  child: _imageFile != null
                      ? FutureBuilder<Size>(
                          future: _getImageSize(_imageFile!),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return LayoutBuilder(
                                builder: (context, constraints) {
                                  double aspectRatio = snapshot.data!.width /
                                      snapshot.data!.height;
                                  double width = constraints.maxWidth;
                                  double height = width / aspectRatio;

                                  if (height > constraints.maxHeight) {
                                    height = constraints.maxHeight;
                                    width = height * aspectRatio;
                                  }

                                  return Stack(
                                    children: [
                                      Image.file(
                                        _imageFile!,
                                        fit: BoxFit.contain,
                                        width: width,
                                        height: height,
                                      ),
                                      CustomPaint(
                                        painter: BoundingBoxPainter(
                                          _predictions,
                                          snapshot.data!,
                                          Size(width, height),
                                        ),
                                        size: Size(width, height),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        )
                      : Image.asset(
                          'assets/png/placeholder.png',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            if (_predictions.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Sampah terdeteksi:',
                  ),
                  const SizedBox(height: 5),
                  Container(
                    decoration: const BoxDecoration(color: Color(0XFFF6F4BD)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        _predictions.map((p) => p.label).join('\n'),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            if (_predictions.isEmpty)
              Column(
                children: [
                  Center(
                    child: SizedBox(
                      width: 171,
                      height: 45,
                      child: OutlinedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(const Color(0xff7ABA78)),
                          side: WidgetStateProperty.all(
                            const BorderSide(
                              color: Color(0xff7ABA78),
                              width: 2,
                            ),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          await _takePicture();
                        },
                        icon: const Icon(Icons.camera_alt_sharp,
                            color: Colors.white),
                        label: const Text(
                          'Ambil Foto',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: SizedBox(
                      width: 171,
                      height: 45,
                      child: OutlinedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.transparent),
                          side: WidgetStateProperty.all(
                            const BorderSide(
                              color: Color(0xff7ABA78),
                              width: 2,
                            ),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          await _pickImage();
                        },
                        icon: const Icon(Icons.file_upload_outlined,
                            color: Color(0xff7ABA78)),
                        label: const Text(
                          'Pilih foto',
                          style: TextStyle(
                            color: Color(0xff7ABA78),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            const SizedBox(height: 10),
            const Text(
              'Nama',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    RenderBox renderBox =
                        context.findRenderObject() as RenderBox;
                    _showDropdownName(context, renderBox);
                  },
                  child: AbsorbPointer(
                    child: WasteAppTextFieldsCustomer(
                      hintText: 'Nama Nasabah',
                      controller: nameController,
                      suffixIcon: true,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            const Text(
              'Tanggal',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            WasteAppDatePicker(
              hintText: 'DD/MM/YYYY',
              controller: dateController,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.8,
                  child: const Text(
                    'Jenis Sampah',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 9,
                  child: const Text(
                    'Berat',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3.4,
                  child: const Text(
                    'Harga',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            for (int i = 1; i < wasteItems.length; i++)
              WasteItemRow(
                index: i,
                wasteTypes: wasteTypes.map((e) => e['name']!).toList(),
                selectedWasteType: wasteItems[i]['wasteType']!,
                onWasteTypeChanged: (value) {
                  setState(() {
                    wasteItems[i]['wasteType'] = value;
                  });
                },
                onAmountChanged: (value) {
                  setState(() {
                    wasteItems[i]['amount'] = value;
                  });
                },
                onDelete: deleteWasteItem,
                onTotalChanged: updateItemTotal,
              ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(color: Colors.green),
                  ),
                  child: TextButton(
                    onPressed: addWasteItem,
                    child: const Text(
                      '+ Tambah Sampah',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.red)),
                  child: TextButton(
                    onPressed: deleteLastWasteItem,
                    child: const Text(
                      '- Hapus Sampah',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 10,
                      ),
                    ),
                  ),
                )
              ],
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            const SizedBox(height: 150),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          ),
        ]),
        child: BottomAppBar(
          elevation: 0,
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Total',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Rp${formatter.format(calculateOverallTotal())}', // IMPLEMENTASI
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff7ABA78),
                  ),
                  child: TextButton(
                    onPressed: _submitDeposits,
                    child: _isloading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Tabung',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
