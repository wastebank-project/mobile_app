import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  List<String> wasteTypes = [];
  List<Map<String, dynamic>> wasteItems = [];
  Map<int, int> itemTotals = {};

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
  void updateItemTotal(int index, int total) {
    setState(() {
      itemTotals[index] = total;
      calculateOverallTotal();
    });
  }

// PENJUMLAHAN SUM TOTAL ITEM
  int calculateOverallTotal() {
    int total = 0;
    itemTotals.forEach((_, value) {
      total += value;
    });
    return total;
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
    final response = await http
        .get(Uri.parse('https://backend-banksampah-api.vercel.app/nasabah'));

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
        .get(Uri.parse('https://backend-banksampah-api.vercel.app/wastetypes'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        wasteTypes = data.map((e) => e['name'] as String).toList();
        wasteTypes.sort();
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

  @override
  Widget build(BuildContext context) {
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
                hintText: 'DD/MM/YYYY', controller: dateController),
            const SizedBox(height: 30),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 195,
                  child: Text(
                    'Jenis Sampah',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'Berat',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Harga',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            for (int i = 0; i < wasteItems.length; i++)
              WasteItemRow(
                index: i,
                wasteTypes: wasteTypes,
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
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        height: 115,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'Total = Rp. ${calculateOverallTotal()}',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 17, 25, 0),
              child: SizedBox(
                width: 350,
                height: 45,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFFF2994A))),
                  onPressed: () {},
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
    );
  }
}
