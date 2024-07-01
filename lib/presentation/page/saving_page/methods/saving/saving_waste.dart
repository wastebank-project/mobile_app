import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:waste_app/presentation/page/saving_page/result/savingSuccess.dart';
import 'package:waste_app/presentation/widgets/date_picker.dart';
import 'package:waste_app/presentation/widgets/text_fields_customers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:waste_app/presentation/widgets/waste_item_row.dart';

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
  Map<int, double> itemTotals = {}; // Change to double

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
    EasyLoading.show(status: 'Loading...');
    if (nameController.text.isEmpty || dateController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Tolong isi Semua Data!';
      });
      return;
    }

    List<Map<String, dynamic>> deposits = wasteItems.map((item) {
      final selectedWasteType = wasteTypes
          .firstWhere((wasteType) => wasteType['name'] == item['wasteType']);
      return {
        'wasteTypeId': selectedWasteType['id'],
        'amount': double.parse(item['amount']), // Handle as double
      };
    }).toList();

    final response = await http.post(
      Uri.parse('${dotenv.env['BASE_URL_BACKEND']}/tabung'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': nameController.text,
        'date': dateController.text,
        'deposits': deposits,
      }),
    );

    if (response.statusCode == 201) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SavingSuccess(),
          ));
      _clearForm();
    } else {
      setState(() {
        _errorMessage = 'Failed to save deposits';
      });
    }
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter =
        NumberFormat('#,##0', 'id_ID'); // FORMAT RIBUAN PEMISAH

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
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            WasteAppDatePicker(
              hintText: 'DD/MM/YYYY',
              controller: dateController,
            ),
            const SizedBox(height: 30),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 180,
                  child: Text(
                    'Jenis Sampah',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'Berat',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 60,
                  child: Text(
                    'Harga',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            for (int i = 0; i < wasteItems.length; i++)
              WasteItemRow(
                index: i,
                wasteTypes: wasteTypes.map((e) => e['name']!).toList(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: addWasteItem,
                  child: const Text(
                    '+ Tambah Sampah',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 10,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: deleteLastWasteItem,
                  child: const Text(
                    '- Hapus Sampah',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 10,
                    ),
                  ),
                )
              ],
            ),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            const SizedBox(height: 50),
            const SizedBox(height: 50)
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
          height: 115,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Rp${formatter.format(calculateOverallTotal())}', // IMPLEMENTASI
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 11, 25, 0),
                child: SizedBox(
                  width: 350,
                  height: 45,
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xFFF2994A))),
                    onPressed: _submitDeposits,
                    child: const Text(
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
